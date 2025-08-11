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

The fundamental problem with starting with a monolith is that it encourages all the wrong patterns from day one. Monoliths make it far too easy to accidentally depend on full consistency rather than embracing eventual consistency. Most difficult race conditions I've encountered are a result of not embracing eventual consistency from the beginning. The "well-abstracted monolith" is a myth – you can't abstract away the fundamental reliability problems that come from synchronous, fully-consistent thinking.

As the {PostLink:critical-questions-about-microservice|Critical Questions About Microservices} framework shows, reliability requires addressing Context, Consistency, Contract, Chaos, Competencies, and Coalescence from the start. You cannot retrofit these critical conversations into a monolith after the fact.

## Building for Reliability From Day One

### 1. Reliability Through Isolation

One of the most compelling arguments for microservices is the inherent reliability gained through service isolation. When a service fails in a monolithic application, it often brings down the entire system. In contrast, microservices architecture allows for graceful degradation:

* Individual service failures remain isolated
* The rest of the system continues functioning
* Recovery can occur without system-wide impact
* Circuit breakers can protect dependent services

You can't retrofit failure isolation into a monolith. As outlined in the Critical C's Chaos principle, teams must ask: "How will we handle the inability to reach a dependency?" With microservices, the answer is built into the architecture.

### 2. Reliability Through Eventual Consistency

One of the key paradigm shifts in microservices architecture is embracing eventual consistency. While this concept might seem challenging at first, it often better reflects real-world business processes. Monoliths trick you into synchronous thinking, creating brittle systems that fail catastrophically.

<!-- 
EDITORIAL NOTES - "The Power of Eventual Consistency" Section:

STRENGTHS:
* Car repair shop analogy is highly effective - makes eventual consistency concept tangible
* Async/await critique shows sophisticated understanding of implementation challenges
* Successfully bridges abstract theory with practical programming concerns
* Strong support for main thesis by reframing eventual consistency as natural

IMPROVEMENT OPPORTUNITIES (TODO):
* Add smoother transition from bullet points to paragraph text
* Consider adding concrete code example to illustrate "sitting in the repair shop" anti-pattern
* Potentially expand the car repair analogy given its effectiveness

OVERALL: One of the stronger sections - preserve and potentially enhance the analogy.

Additional note: This section is one of the key reasons, maybe it should be up higher?
-->

It is only people that tend to want full-consistency, the processes don't care.

Our typical patterns are the functional equivalent of waiting at the repair shop for our car to be fixed, when we also need to do the grocery shopping, mail packages, and have lunch. If we truly can't do those things without OUR car, then ok, but most of the time, we can walk, get a rental from the shop, or have someone pick us up so we can accomplish all of our tasks with a similar effort and timeframe to just doing the longest of them.

Unfortunately, this is one place where the languages don't really help us. `Async/Await` is amazing for what it does, but most of our `async` methods simply `await` a response. They sit in the repair shop. We should be leaving that repair shop and coming back later. Monoliths make it way too easy to accidentally sit and wait for an answer, and once implemented, those patterns can be much harder to replace than simply respecting asynchrony from the start.

But here's the hidden benefit: **Eventually consistent systems using reliable messaging patterns like Service Bus or Apache Kafka are inherently self-healing**. When a service is temporarily unavailable, messages queue up. When it returns, processing resumes automatically. No manual intervention, no 3am calls. The system heals itself.

Could a monolith use these same messaging patterns? Technically, yes. But monoliths don't make this pattern a first-class citizen. In a monolith, it's far easier to make a direct method call than to set up messaging infrastructure. Microservices, by their very nature, push you toward these resilient patterns from the start. The path of least resistance in microservices leads to self-healing systems; in monoliths, it leads to brittle, synchronous coupling.

This aligns with the Critical C's Consistency conversations: "What patterns and tools will we use to create systems that support reliable, eventually consistent operations?"

### 3. Scalability as Operational Reliability

Microservices enable precise scaling of specific functionality, preventing system-wide performance degradation:

* High-demand services can scale independently
* Resource allocation becomes more efficient
* Cost optimization is more granular
* Performance bottlenecks are easier to identify and address

Following the Coalescence principle, teams need unified logging and traceability to monitor these scaling behaviors and ensure operational reliability.

### 4. Team Autonomy as Deployment Reliability

Modern development teams thrive when they can work independently. More importantly, independent deployments mean isolated risk:

* Teams can own their services end-to-end
* Deployment cycles are shorter and lower risk
* Technology choices can be optimized per service
* Parallel development becomes more natural

The Contract principle ensures teams ask: "How will we isolate our internal data representations from those of our downstream consumers?" This isolation is impossible in a monolith.

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

This fundamentally violates the Contract principle – you can't "isolate internal data representations" when everything shares the same memory space, the same database transactions, and the same deployment lifecycle.

### The Refactoring Myth
You won't refactor to microservices when you need to – you'll be too busy fighting fires. The statistics are clear: most "temporary" monoliths become permanent technical debt. When your system is down at 3am, nobody's thinking about architectural improvements. **And thanks to coupling creep, even if you had time, the refactoring would be nearly impossible.**

### The Abstraction Trap
Abstractions without process boundaries are just prettier failure points. You can organize your monolith beautifully, but when one component fails, it still takes down everything. A well-structured house of cards is still a house of cards.

### The Technical Debt Spiral
Every monolithic "temporary solution" becomes permanent. As the Context principle warns, business processes implemented unreliably become normalized. Teams must ask: "What processes will we implement to track and manage the technical debt of having business processes implemented in a less-reliable way?"

### The Testing Bottleneck
Monolithic testing becomes a reliability nightmare:

* Test suites grow from minutes to hours
* Can't test components in true isolation
* Integration tests become the only "real" tests
* Slow tests discourage frequent deployments, increasing batch size and risk

The Chaos principle asks: "How will we expose possible sources of failures during pre-deployment testing?" In a monolith, the answer is often "we can't."

### The Deployment Fear
Every monolithic deployment is a reliability gamble:

* One bad change can bring down unrelated features
* Rollbacks affect the entire system, not just the problem area
* Teams batch changes to reduce deployment frequency, paradoxically increasing risk
* "Never deploy on Friday" becomes policy because weekends are for outages

This directly contradicts the Coalescence principle's need to "identify, as quickly as possible, when a deployment has had a negative impact."

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

These benefits align with all six Critical C's:
- **Context**: Proper event sourcing and idempotency
- **Consistency**: Embracing eventual consistency patterns
- **Contract**: Well-defined service boundaries
- **Chaos**: Built-in failure handling
- **Competencies**: Leveraging platform capabilities
- **Coalescence**: Unified observability from the start

## Critical Conversations for Reliability

<!-- TODO: Expand this section with specific questions from each Critical C that teams should discuss when starting with microservices -->

Before building your microservices architecture, have these critical conversations:

### Context Conversations
* What database technologies will we use to create downstream events?
* Which services can be made idempotent to improve reliability?

### Consistency Conversations  
* How will we prevent demands for synchronous consistency from creeping in?
* How will we identify delays in reaching eventual consistency?

### Contract Conversations
* What procedures will monitor our service contracts for compatibility?
* How will we version our APIs to maintain backward compatibility?

### Chaos Conversations
* How will we handle duplicate or out-of-order messages?
* How will we expose failures before they impact users?

### Competency Conversations
* What are our core competencies vs. what should we buy?
* Which platform capabilities can we leverage?

### Coalescence Conversations
* How quickly can we identify when a deployment has negative impact?
* What observability tools will give us system-wide visibility?

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

<!-- TODO: Add section on specific reliability patterns (circuit breakers, retries, timeouts, bulkheads) organized by Critical C's -->

## Conclusion

The debate isn't really about microservices vs. monoliths – it's about whether you're willing to invest in reliability from the start. Those advocating for monolith-first approaches are making a false trade-off – they're not actually reducing complexity, they're just hiding it in a single deployment at the cost of long-term reliability.

The software industry has evolved to a point where microservices should be the default architectural choice for most implementations. The benefits of reliability, scalability, and team autonomy come from better organization of the same inherent complexity. While monolithic architecture still has its place, it should be the exception rather than the rule.

In a world where software failures make headlines, can you really afford to start with anything less than a reliability-first architecture? Don't let anyone convince you to "start simple" when what they really mean is "start unreliable."

By making microservices your default architectural choice, you're not just following a trend – you're making a commitment to building systems that can withstand the inevitable failures and changes that all software faces.
