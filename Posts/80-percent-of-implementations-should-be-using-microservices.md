---
tags:
- microservices
menuorder: 0
id: 2eabd648-feb1-4f89-beb7-8f3a29dc6828
author: bsstahl
title: 80&#37; of Implementations Should be Using Microservices
description: Explore why microservices should be the default architecture for most modern software implementations. This post highlights the advantages of microservices over monolithic architectures, focusing on reliability. Gain insights into the importance of eventual consistency and learn about the challenges and benefits involved in transitioning to microservices after-the-fact. Perfect for developers and architects looking to make informed decisions about their software design, and for ignoring the well-intentioned but dangerous hype around &quot;well-architected monoliths&quot;.
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2025-05-17T19:18:35.000+00:00
lastmodificationdate: 2025-05-17T19:18:35.000+00:00
slug: 80-percent-of-implementations-should-be-using-microservices
categories:
- Development

---
The debate between monolithic and microservices architectures continues to spark passionate discussions. However, based on years of experience and observation across innumerable implementations, I believe that the default pattern for most modern software implementations should be to use a microservices architecture. This isn't just a trend - it's a practical necessity driven by the demands of modern software development.

Lately, we are often advised to "start with a well-abstracted monolith". This, in my opinion, is dangerously misguided. This recommendation ignores the fundamental reliability requirements of most modern software systems. Here's why microservices should be your default choice, with reliability as the primary driver.

## The Monolith-First Fallacy

The fundamental problem with starting with a monolith is that it encourages many of the wrong patterns from day one. Monoliths make it far too easy to accidentally depend on full consistency rather than embracing eventual consistency. Most difficult race conditions I've encountered are a result of not embracing eventual consistency from the beginning. The "well-abstracted monolith" is a myth – you can't abstract away the fundamental reliability problems that come from synchronous, fully-consistent thinking.

The six-part {PostLink:critical-cs-of-microservices-1of6-context|Critical C's of Microservices} series explores the conversations behind reliable event-driven systems: {PostLink:critical-cs-of-microservices-1of6-context|Context}, {PostLink:critical-cs-of-microservices-2of6-consistency|Consistency}, {PostLink:critical-cs-of-microservices-3of6-contract|Contract}, {PostLink:critical-cs-of-microservices-4of6-chaos|Chaos}, {PostLink:critical-cs-of-microservices-5of6-competencies|Competencies}, and {PostLink:critical-cs-of-microservices-6of6-coalescence|Coalescence}. The companion {PostLink:critical-questions-about-microservice|Critical Questions About Microservices} article gathers the questions in one place; this article focuses on why microservices can be a sensible default.

## Simplicity Through Natural Boundaries

While monolithic architectures *can* implement all of the patterns designed to make our systems reliable, microservices make these patterns natural, simpler, and the path of least resistance. This distinction is crucial because **simplicity is critical everywhere in our systems, but it is most important within the reliability aspects**. Reliability-critical paths (failover, error handling, recovery) must remain simple. Microservices achieve this simplicity by making reliable patterns the default choice rather than requiring extra effort.

Since everything in software engineering is a trade-off, we should be willing to accept minor increases in operational complexity (like service discovery or distributed tracing) in exchange for dramatic simplification of our reliability-critical paths. Reliable messaging is only as good as the boundaries it enforces – and microservices enforce these boundaries, often by default.

### 1. Reliability Through Isolation

One of the most compelling arguments for microservices is the inherent reliability gained through service isolation. When a service fails in a monolithic application, it often brings down the entire system. In contrast, microservices architecture allows for graceful degradation:

* Individual service failures remain isolated
* The rest of the system continues functioning
* Recovery can occur without system-wide impact
* Circuit breakers can protect dependent services

Service boundaries can limit the impact of a failure, but they do not guarantee isolation on their own. Teams still need to decide how the system will behave when a dependency is unavailable.

### 2. Reliability Through Eventual Consistency

One of the key paradigm shifts in microservices architecture is embracing eventual consistency. While this concept might seem challenging at first, it often better reflects real-world business processes. Monoliths trick you into synchronous thinking, creating brittle systems that fail catastrophically.

It is only people that tend to want full-consistency, the processes don't care.

Our typical patterns are the functional equivalent of waiting at the repair shop for our car to be fixed, when we also need to do the grocery shopping, mail packages, and have lunch. If we truly can't do those things without OUR car, then ok, but most of the time, we can walk, get a rental from the shop, or have someone pick us up so we can accomplish all of our tasks with a similar effort and timeframe to just doing the longest of them.

Unfortunately, this is one place where the languages don't really help us. `Async/Await` is amazing for what it does, but most of our `async` methods simply `await` a response. They sit in the repair shop. We should be leaving that repair shop and coming back later. Monoliths make it way too easy to accidentally sit and wait for an answer, and once implemented, those patterns can be much harder to replace than simply respecting asynchrony from the start.

But here's the hidden benefit: **Eventually consistent systems using reliable messaging patterns like Service Bus or Apache Kafka are inherently self-healing**. When a service is temporarily unavailable, messages queue up. When it returns, processing resumes automatically. No manual intervention, no 3am calls. The system heals itself.

Could a monolith use these same messaging patterns? Technically, yes. But monoliths don't make this pattern a first-class citizen. In a monolith, it's far easier to make a direct method call than to set up messaging infrastructure. Microservices, by their very nature, push you toward these resilient patterns from the start. The path of least resistance in microservices leads to self-healing systems; in monoliths, it leads to brittle, synchronous coupling.

### 3. Scalability as Operational Reliability

Microservices enable precise scaling of specific functionality, preventing system-wide performance degradation:

* High-demand services can scale independently
* Resource allocation becomes more efficient
* Cost optimization is more granular
* Performance bottlenecks are easier to identify and address

Scalability is only one of the benefits of event-driven microservices; see {PostLink:microservices-not-just-about-scale|Microservices - Not Just About Scalability} for the broader case.

### 4. Team Autonomy as Deployment Reliability

Modern development teams thrive when they can work independently. More importantly, independent deployments mean isolated risk:

* Teams can own their services end-to-end
* Deployment cycles are shorter and lower risk
* Technology choices can be optimized per service
* Parallel development becomes more natural

## Why "Start with a Monolith" Fails

The monolith-first approach fails on multiple reliability dimensions:

### The Coupling Creep (The Most Insidious Failure)

Of all the ways monoliths fail, coupling creep is the most dangerous because it happens gradually, invisibly, and irreversibly. It's the architectural equivalent of boiling a frog:

* **Day 1**: "We'll keep clean boundaries between our modules"
* **Month 1**: "Just this once, we'll directly call that other module's internal method"
* **Month 6**: "We need a database transaction across these three domains for consistency"
* **Year 1**: "Nobody knows what depends on what anymore"

In monoliths, coupling spreads through the path of least resistance:

* Direct method calls are easier than message passing, so developers take shortcuts
* Shared database transactions create hidden dependencies across business domains
* "Temporary" shared data models become permanent coupling points
* Performance optimizations lead to bypassing abstractions
* What starts as "clean architecture" inevitably devolves into a big ball of mud

**This is why coupling creep is so insidious**: Each individual decision seems reasonable. Each shortcut saves time. Each optimization improves performance. But collectively, they create an inescapable web of dependencies that makes the eventual refactoring to microservices nearly impossible.

### The Refactoring Myth

You won't refactor to microservices when you need to – you'll be too busy fighting fires. The statistics are clear: most "temporary" monoliths become permanent technical debt. When your system is down at 3am, nobody's thinking about architectural improvements. **And thanks to coupling creep, even if you had time, the refactoring would be nearly impossible.**

### The Abstraction Trap

Abstractions without process boundaries are just prettier failure points. You can organize your monolith beautifully, but when one component fails, it still takes down everything. A well-structured house of cards is still a house of cards.

### The Technical Debt Spiral

Every monolithic "temporary solution" can become permanent. The longer these compromises remain, the harder they are to unwind.

### The Testing Bottleneck

Monolithic testing becomes a reliability nightmare:

* Test suites grow from minutes to hours
* Can't test components in true isolation
* Integration tests become the only "real" tests
* Slow tests discourage frequent deployments, increasing batch size and risk

### The Deployment Fear

Every monolithic deployment is a reliability gamble:

* One bad change can bring down unrelated features
* Rollbacks affect the entire system, not just the problem area
* Teams batch changes to reduce deployment frequency, paradoxically increasing risk
* "Never deploy on Friday" becomes policy because weekends are for outages

## Addressing the Monolith Advocates

Proponents of monolithic architecture often cite several concerns that, while well-intentioned, don't hold up under scrutiny:

### "Monoliths are simpler"

This is a fundamental misunderstanding. Monoliths and microservices have the same inherent complexity – the difference is how that complexity is organized. Monoliths hide complexity by munging it all together in one deployment:

* The same business logic exists in both architectures
* The same integrations and dependencies exist
* The same data flows and transformations occur
* But in monoliths, all this complexity is tangled together in one place

As systems grow, monolithic organization makes complexity harder to manage:

* Dependencies become more tangled without clear boundaries
* Testing becomes more challenging when everything is interconnected
* Deployment risk increases because all complexity deploys together
* Cognitive load increases because developers must understand the entire system

Microservices don't add complexity – they organize it into manageable, isolated units.

### "Microservices add overhead"

That "overhead" is not additional complexity – it's making existing complexity visible and manageable:

* The "overhead" is reliability infrastructure you'll need anyway
* What seems like added complexity is actually proper separation of concerns
* Modern tools and platforms simplify management of distributed systems
* The investment in explicit boundaries pays off in reduced maintenance costs
* Making complexity visible enables better monitoring, debugging, and scaling

The perceived overhead is actually the cost of doing things correctly from the start.

### "Start simple and refactor later"

You're betting your reliability on a refactoring that statistics show rarely happens. This is perhaps the most dangerous advice in software architecture.

## When to Consider a Monolith

The 20% where monoliths make sense have one thing in common: reliability isn't critical. Choose a monolith only when ALL of these are true:

* The application has extremely limited scope with no growth expectations
* You have a very small team (1-2 developers) with no plans to expand
* It's a true proof-of-concept that will be discarded
* The application has extreme latency or consistency requirements that override reliability concerns
  * Note: This is only the case when the extreme requirements are REAL. Many users think they need these types of latency or consistency guarantees when they really don't. The situations where these are necessary in the typical enterprise world are vanishingly rare.
* Downtime is acceptable and won't impact users or business operations

If you're unsure, you probably need microservices. Uncertainty about future requirements is exactly why you need failure isolation.

## The Reliability Dividend

Every architectural decision compounds over time. With microservices:

* Every failure isolated is a 3am call avoided
* Every service boundary is a blast radius limit
* Every independent deployment is a risk reduction
* Every asynchronous pattern is a cascading failure prevented
* Every reliable messaging pattern enables self-healing – another 3am call avoided

## Transitioning from Monolith to Microservices

Many organizations face the challenge of transitioning existing monolithic applications to microservices. While this process can be complex, it's often necessary and can be managed effectively:

### Strangler Fig Pattern

* Gradually replace functionality with services
* Keep the monolith running during transition
* Minimize risk through incremental changes
* Validate the approach with initial services

### Key Transition Strategies

* Start with new features as services
* Identify natural service boundaries
* Use event-driven patterns for integration
* Implement robust monitoring early

## Conclusion

The debate isn't really about microservices vs. monoliths – it's about whether you're willing to invest in reliability from the start. Those advocating for monolith-first approaches are making a false trade-off – they're not actually reducing complexity, they're just hiding it in a single deployment at the cost of long-term reliability. Either that or they are assuming that the system will never amount to anything of significance (it won't ever be deployed, last long, or need to be maintained or extended).

The software industry has evolved to a point where microservices should be the default architectural choice for most implementations. We have the tools available to us to implement these patterns simply, and the benefits of reliability, scalability, and team autonomy come from better organization of the same inherent complexity. While monolithic architecture still has its place, it should be the exception rather than the rule.

In a world where software failures make headlines, can you really afford to start with anything less than a reliability-first architecture? Don't let anyone convince you to "start simple" when what they really mean is "start unreliable."

By making microservices your default architectural choice, you're not just following a trend – you're making a commitment to building systems that can withstand the inevitable failures and changes that all software faces.
