---
author: bsstahl
tags:
- agile
- antipattern
- apache-kafka
- api
- apps
- architecture
- aspdotnet
- ci_cd
- coding-practices
- coupling
- event-driven
- microservices
- soa
menuorder: 0
id: 0d794105-ef08-4465-b806-4a8eff7523c7
title: The Critical C's of Microservices - Chaos
description: A series of conversations that development teams should have around building event driven or microservice architectures
ispublished: true
showinlist: false
publicationdate: 2023-01-02T07:00:00Z
lastmodificationdate: 2023-01-02T07:00:00Z
slug: critical-cs-of-microservices-4of6-chaos
categories:
- Development

---
&quot;**The Critical C's of Microservices**&quot; are a series of conversations that development teams should have around building event-driven or other microservice based architectures. These topics will help teams determine which architectural patterns are best for them, and assist in building their systems and processes in a reliable and supportable way.

The &quot;Critical C's&quot; are: **Context**, **Consistency**, **Contract**, **Chaos**, **Competencies** and **Coalescence**. Each of these topics will be covered in detail in this series of articles. The first article of the 6 was on the subject of {PostLink:critical-cs-of-microservices-1of6-context|Context}. This is article 4 of the series, and covers the topic of **Chaos**.

#### Chaos

One of the [Fallacies of Distributed Computing](https://en.wikipedia.org/wiki/Fallacies_of_distributed_computing) is that the network is reliable. We should have similarly low expectations for the reliability of all of the infrastructure on which our services depend. Networks will segment, commodity servers and drives will fail, containers and operating systems will become unstable. In other words, our software will have errors during operation, no matter how resilient we attempt to make it. We need to embrace the fact that failures will occur in our software, and will do so at random times and often in unpredictable ways.

If we are to build systems that don't require our constant attention, especially during off-hours, we need to be able to identify what happens when failures occur, and design our systems in ways that will allow them to heal automatically once the problem is corrected.

To start this process, I recommend playing "what-if" games using diagrams of the system. Walk through the components of the system, and how the data flows through it, identifying each place where a failure could occur. Then, in each area where failures could happen, attempt to define the possible failure modes and explore what the impact of those failures might be. This kind of "virtual" Chaos Engineering is certainly no substitute for actual experimentation and testing, but is a good starting point for more in-depth analysis. It also can be very valuable in helping to understand the system and to produce more hardened services in the future.

Thought experiments are useful, but you cannot really know how a system will respond to different types of failures until you have those failures in production. Historically, such "tests" have occurred at random, at the whim of the infrastructure, and usually at the worst possible time. Instead of leaving these things to chance, tools like *Chaos Monkey* can be used to simulate failures in production, and can be configured to create these failures during times where the appropriate support engineers are available and ready to respond if necessary. This way, we can see if our systems respond as we expect, and more importantly, heal themselves as we expect.

Even if you're not ready to jump into using automated experimentation tools in production just yet, a lot can be learned from using feature-flags and changing service behaviors in a more controlled manner as a starting point. This might involve a flag that can be set to cause an API method to return an error response, either as a hard failure, or during random requests for a period of time. Perhaps a switch could be set to stop a service from picking-up asynchronous messages from a queue or topic. Of course, these flags can only be placed in code we control, so we can't test failures of dependencies like databases and other infrastructure components in this way. For that, we'll need more involved testing methods.

Regardless of how we test our systems, it is important that we do everything we can to build systems that will heal themselves without the need for us to intervene every time a failure occurs. As a result, I highly recommend using asynchronous messaging patterns whenever possible. The asynchrony of these tools allow our services to be "temporally decoupled" from their dependencies. As a result, if a container fails and is restarted by Kubernetes, any message in process is rolled-back onto the queue or topic, and the system can pick right up where it left off.

#### Goals of the Conversation

Development teams should have conversations around **Chaos** that are primarily focused around procedures for identifying and remediating possible failure points in the application. These conversations should include answering questions like:

* How will we evaluate potential sources of failures in our systems before they are built?
  * How will we handle the inability to reach a dependency such as a database?
  * How will we handle duplicate messages sent from our upstream data sources?
  * How will we handle messages sent out-of-order from our upstream data sources?
* How will we expose possible sources of failures during any pre-deployment testing?
* How will we expose possible sources of failures in the production environment before they occur for users?
* How will we identify errors that occur for users within production?
* How will we prioritize changes to the system based on the results of these experiments?

#### Next Up - Competencies

In the next article of this series we will look at {PostLink:critical-cs-of-microservices-5of6-competencies|Competencies} and how we should focus at least as much on what we build as how we build it.
