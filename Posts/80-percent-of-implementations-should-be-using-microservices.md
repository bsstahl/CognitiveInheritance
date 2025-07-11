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
The debate between monolithic and microservices architectures continues to spark passionate discussions. However, based on years of experience and observation across numerous implementations, I firmly believe that approximately 80% of modern software implementations should be built using microservices architecture. This isn't just a trend - it's a practical necessity driven by the demands of modern software development.

## Why Microservices Should Be Your Default Choice

### 1. Reliability Through Isolation

One of the most compelling arguments for microservices is the inherent reliability gained through service isolation. When a service fails in a monolithic application, it often brings down the entire system. In contrast, microservices architecture allows for graceful degradation:

* Individual service failures remain isolated
* The rest of the system continues functioning
* Recovery can occur without system-wide impact
* Circuit breakers can protect dependent services

### 2. Scalability Where It Matters

Microservices enable precise scaling of specific functionality:

* High-demand services can scale independently
* Resource allocation becomes more efficient
* Cost optimization is more granular
* Performance bottlenecks are easier to identify and address

### 3. Team Autonomy and Velocity

Modern development teams thrive when they can work independently:

* Teams can own their services end-to-end
* Deployment cycles are shorter and lower risk
* Technology choices can be optimized per service
* Parallel development becomes more natural

## The Power of Eventual Consistency

One of the key paradigm shifts in microservices architecture is embracing eventual consistency. While this concept might seem challenging at first, it often better reflects real-world business processes:

* Most business processes are naturally eventually consistent
* Reduced coupling between services
* Better handling of distributed system realities
* Improved system resilience

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

## Addressing the Monolith Advocates

Proponents of monolithic architecture often cite several concerns that, while well-intentioned, don't hold up under scrutiny:

### "Monoliths are simpler"

This is only true in the short term. As systems grow:

* Monolithic codebases become increasingly complex
* Dependencies become more tangled
* Testing becomes more challenging
* Deployment risk increases

### "Microservices add overhead"

While there is some truth to this, the benefits typically outweigh the costs:

* Initial setup complexity is a one-time cost
* Modern tools and platforms simplify management
* The overhead is offset by reduced maintenance costs
* Improved reliability justifies the investment

## When to Consider a Monolith

While microservices should be the default choice, there are legitimate cases for monolithic architecture:

* Extremely simple applications with limited scope
* Projects with very small teams and minimal growth expectations
* Proof-of-concept implementations
* Applications with extreme latency requirements

However, these cases represent the minority of modern software implementations.

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

The software industry has evolved to a point where microservices should be the default architectural choice for most implementations. The benefits of reliability, scalability, and team autonomy far outweigh the initial complexity. While monolithic architecture still has its place, it should be the exception rather than the rule.

The key is to approach microservices pragmatically:

* Start with clear service boundaries
* Embrace eventual consistency
* Implement robust monitoring and observability
* Focus on automation and DevOps practices

By making microservices your default architectural choice, you're setting your implementation up for better scalability, maintainability, and long-term success in today's dynamic software landscape.
