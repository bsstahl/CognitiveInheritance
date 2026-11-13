---
tags:
- microservices
menuorder: 0
id: 2eabd648-feb1-4f89-beb7-8f3a29dc6828
author: bsstahl
title: 80&#37; of Implementations Should be Using Microservices
description: Explore why microservices should be the default architecture for most modern software implementations. This post highlights the advantages of microservices over monolithic architectures, focusing on reliability.
ispublished: true
showinlist: false
buildifnotpublished: true
publicationdate: 2027-11-13T07:00:00.000+00:00
lastmodificationdate: 2027-11-13T07:00:00.000+00:00
slug: 80-percent-of-implementations-should-be-using-microservices
categories:
- Development

---
Most modern software systems should use microservices by default. Clear service boundaries help isolate failures, support eventual consistency, and let teams deploy changes independently.

Monoliths can simplify local calls and deployment, but they do not remove complexity. Shared data, cross-domain transactions, and hidden dependencies make systems harder to reason about. These shortcuts also encourage coupling, making failures harder to contain, deployments riskier, and a later split more expensive. Monoliths can use reliable patterns, but microservices make them easier to adopt from the start, and harder to move away from accidentally.

Monoliths can seem simpler because they make direct calls and shared data easier, but those very conveniences are often what encourages coupling and adds complexity later.

## The Monolith-First Fallacy

The fundamental problem with starting with a monolith is that it encourages, or at least does not prevent, several distributed systems anti-patterns. For example, monoliths make it far too easy to accidentally depend on full consistency rather than embracing eventual consistency. Most of the difficult race conditions I've encountered in my career have been a result of not embracing eventual consistency from the beginning. 

A monolith can be well-abstracted, but keeping its boundaries and reliability patterns intact as the system grows can be nearly impossible; the path of least resistance gradually pulls teams toward direct calls and synchronous consistency.

> ...if a problem were to occur late Friday afternoon, would it be ok for it to wait until Monday to be fixed? If not, a monolith probably doesn't provide the needed reliability profile.

## Simplicity Through Natural Boundaries

While monolithic architectures *can* implement all of the patterns designed to make our systems reliable, microservices make these patterns natural, simpler, and the path of least resistance. This distinction is crucial because **simplicity is critical everywhere in our systems, but it is most important within the reliability aspects**. Reliability-critical paths (failover, error handling, recovery) must remain simple. Microservices achieve this simplicity by making reliable patterns the default choice rather than requiring extra effort.

Since everything in software engineering is a trade-off, we should be willing to accept minor increases in operational complexity (like service discovery or distributed tracing) in exchange for dramatic simplification of our reliability-critical paths. Reliable messaging is only as good as the boundaries it enforces. Microservices often enforce these boundaries by default.

### 1. Reliability Through Isolation

One of the most compelling arguments for microservices is the inherent reliability gained through service isolation. When a service fails in a monolithic application, it often brings down the entire system. In contrast, microservices architecture allows for graceful degradation:

* Individual service failures remain isolated
* The rest of the system continues functioning
* Recovery can occur without system-wide impact
* Circuit breakers can protect dependent services

Service boundaries can limit the impact of a failure, but they do not guarantee isolation on their own. Teams still need to decide how the system will behave when a dependency is unavailable. The same question applies to monoliths when they depend on external services or shared infrastructure. Inside a monolith, direct calls can make dependencies and failure behavior less visible, so teams may be less likely to design for them explicitly.

### 2. Reliability Through Eventual Consistency

One of the key paradigm shifts in microservices architecture is embracing eventual consistency. While this concept might seem challenging at first, it often better reflects real-world business processes. Monoliths trick you into synchronous thinking, creating brittle systems that fail catastrophically.

We often expect every part of a workflow to be up to date before the system responds. But some work can safely finish later. For example, once an order is accepted and inventory is reserved, its confirmation email can be queued and sent later. If checkout waits for the email service, an outage there can block an otherwise valid order. Eventual consistency lets the email catch up; it does not mean relaxing consistency where the business requires it.

`async`/`await` helps code wait without blocking, but it does not make a workflow eventually consistent. Many `async` methods still wait for a response before proceeding. To let work finish later, the system must hand it off reliably and allow the caller to move on. Monoliths make direct calls easier than message handoffs, so synchronous patterns are easy to introduce and harder to replace later.

But here's the hidden benefit: **Eventually consistent systems using reliable messaging patterns like Service Bus or Apache Kafka are inherently self-healing**. When a service is temporarily unavailable, messages queue up. When it returns, processing resumes automatically. No manual intervention, no 3am calls. The system heals itself.

Could a monolith use these same messaging patterns? Technically, yes. But monoliths don't make this pattern a first-class citizen. In a monolith, it's far easier to make a direct method call than to set up messaging infrastructure. Microservices, by their very nature, push you toward these resilient patterns from the start. The path of least resistance in microservices leads to self-healing systems; in monoliths, it leads to brittle, synchronous coupling.

### 3. Scalability as Operational Reliability

Microservices enable precise scaling of specific functionality, preventing system-wide performance degradation:

* High-demand services can scale independently
* Resource allocation becomes more efficient
* Cost optimization is more granular
* Performance bottlenecks are easier to identify and address

Scalability is only one of the benefits of event-driven microservices; see {PostLink:microservices-not-just-about-scale|Microservices - Not Just About Scalability} for the broader case.

### 4. Team Autonomy and Deployment Reliability

Modern development teams thrive when they can work independently. Independent deployments mean isolated risk:

* Teams can own their services end-to-end
* Deployment cycles are shorter and lower risk
* Technology choices can be optimized per service
* Parallel development becomes more natural

By contrast, monolithic deployments put more of the application at risk at once:

* One bad change can bring down unrelated features
* Rollbacks affect the entire system, not just the problem area
* Teams may batch changes to reduce deployment frequency, increasing the risk of each release
* "Never deploy on Friday" can become policy because the consequences are difficult to contain

## Why "Start with a Monolith" Fails

The strongest argument against starting with a monolith is not that it cannot be well designed. It is that coupling tends to increase along the path of least resistance, amplifying the deployment risks described above.

### The Coupling Creep (The Most Insidious Failure)

Coupling creep is particularly dangerous because it usually happens gradually, invisibly, and with each individual step appearing reasonable. It is the architectural equivalent of boiling the metaphorical frog:

* **Day 1**: "We'll keep clean boundaries between our modules"
* **Month 1**: "Just this once, we'll directly call that other module's internal method"
* **Month 6**: "We need a database transaction across these three domains for consistency"
* **Year 1**: "Nobody knows what depends on what anymore"

In a monolith, coupling spreads through the path of least resistance:

* Direct method calls are easier than message passing, so it is natural to take the shortcut
* Shared database transactions create hidden dependencies across business domains
* "Temporary" shared data models become permanent coupling points
* Performance optimizations can encourage developers to bypass abstractions
* What begins as clean architecture can gradually become a big ball of mud

**This is why coupling creep is so insidious**: each decision can be justified in isolation. The shortcut saves time, and the optimization improves performance. Collectively, however, these decisions create a web of dependencies that makes a later refactoring to microservices much more expensive, if not effectively impossible.

### "bUt OuR tEaM cAn'T hAnDlE mIcRoSeRvIcEs"

This kind of statement may describe the team’s current experience, but it should not determine which architecture the system needs. "We can't" may describe an addressable skills gap, or it may describe a genuine organizational capacity constraint; those are not the same problem.

If the team lacks the skills to build and operate reliable services, the answer is to close that gap: teach the patterns, provide a platform and guardrails, and build experience incrementally. "We don’t know how yet" is a reason to invest in learning, not a permanent architectural principle. The people responsible for the system also have a responsibility to help the team become capable of operating it reliably.

An organization that cannot provide the necessary training, time, staffing, platform, or operational support presents a different problem. If the team cannot realistically own the reliability and operational consequences of microservices, that is a genuine organizational capacity constraint, not merely a skills gap to be dismissed. It may make a monolith the better choice for now, but the decision should say so explicitly and account for the consequences. "Our team can’t handle microservices" is not a sufficient rebuttal until we identify which problem we actually have and address the one that is addressable.

I suspect that we’ll all agree, at least in principle, that any argument reducing the issue to "the team members are too dumb to handle it" is ridiculous and can be dismissed outright. Unfortunately, I still hear arguments like that, and I will always shut them down.

In a future article, I’ll take a broader look at some of these tradeoffs, including testing, complexity, and operational overhead.

## When to Consider a Monolith

The roughly 20% of cases where monoliths make sense have one thing in common: reliability isn't critical. We should choose a monolith only when ALL of the following are true:

* The application has extremely limited scope with no growth expectations
* You have a very small team (1-2 developers) with no plans to expand
* The application has extreme latency or consistency requirements that override reliability concerns.
  * Be skeptical of these types of claims. Systems are often designed around theoretical latency or consistency requirements that are never actually validated against business outcomes.
  * Requirements that truly justify these tradeoffs are relatively rare in line-of-business software. They are more commonly found in real-time, embedded, control, infrastructure, or other systems-engineering domains where timing and correctness constraints are fundamental to the system's purpose.
* Downtime is acceptable and won't impact users or business operations
  * That is, if a problem were to occur late Friday afternoon, would it be ok for it to wait until Monday to be fixed? If not, a monolith probably doesn't provide the needed reliability profile.

OR

* The application is a **true proof-of-concept that will be discarded**

If you're unsure, you probably need microservices. Uncertainty about future requirements is a very good reason for requiring strong failure isolation.

## The Reliability Dividend

Every architectural decision compounds over time. With microservices:

* Every failure isolated is a 3am call avoided
* Every service boundary is a blast radius limit
* Every independent deployment is a risk reduction
* Every asynchronous pattern is a cascading failure prevented
* Every reliable messaging pattern enables self-healing and can mean one less 3am call

## Conclusion

The case for microservices is not that monoliths are always wrong, or that microservices automatically provide reliability. It is that explicit service boundaries and asynchronous communication make reliability concerns part of the design rather than an afterthought. For many systems, that makes microservices the stronger default, provided the team can learn and operate the required patterns effectively.

An addressable skills gap should not become a permanent architectural principle: teams can build experience with training, platform support, and guardrails. A genuine organizational capacity constraint is different, but it does not, by itself, make a monolith the right choice. A monolith is appropriate only when the application meets the conditions described above, or when it is a true proof of concept that will be discarded. Otherwise, the capacity constraint must be addressed rather than used to justify the wrong architecture.

When reliability and independent change matter, microservices provide a stronger starting point, not a guarantee. Teams still need reliable messaging, deliberate failure handling, and sufficient observability to realize the benefits.

## Further Reading

For more on the design conversations behind reliable event-driven systems, see the six-part {PostLink:critical-cs-of-microservices-1of6-context|Critical C's of Microservices} series: {PostLink:critical-cs-of-microservices-1of6-context|Context}, {PostLink:critical-cs-of-microservices-2of6-consistency|Consistency}, {PostLink:critical-cs-of-microservices-3of6-contract|Contract}, {PostLink:critical-cs-of-microservices-4of6-chaos|Chaos}, {PostLink:critical-cs-of-microservices-5of6-competencies|Competencies}, and {PostLink:critical-cs-of-microservices-6of6-coalescence|Coalescence}. The companion {PostLink:critical-questions-about-microservice|Critical Questions About Microservices} article gathers those questions in one place.
