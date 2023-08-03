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
id: a99861ed-9829-4110-9e2f-1e75efcb43a2
title: The Critical C's of Microservices - Competencies
description: A series of conversations that development teams should have around building event driven or microservice architectures
ispublished: true
showinlist: false
publicationdate: 2023-01-09T07:00:00Z
lastmodificationdate: 2023-01-09T07:00:00Z
slug: critical-cs-of-microservices-5of6-competencies
categories:
- Development

---
&quot;**The Critical C's of Microservices**&quot; are a series of conversations that development teams should have around building event-driven or other microservice based architectures. These topics will help teams determine which architectural patterns are best for them, and assist in building their systems and processes in a reliable and supportable way.

The &quot;Critical C's&quot; are: **Context**, **Consistency**, **Contract**, **Chaos**, **Competencies** and **Coalescence**. Each of these topics will be covered in detail in this series of articles. The first article of the 6 was on the subject of {PostLink:critical-cs-of-microservices-1of6-context|Context}. This is article 5 of the series, and covers the topic of **Competencies**.

#### Competencies

It is our responsibility as engineers to spend our limited resources on those things that give the companies we are building for a competitive advantage in the market. This means limiting our software builds to areas where we can differentiate that company from others. Not every situation requires us to build a custom solution, and even when we do, there is usually no need for us to build every component of that system.

If the problem we are solving is a common one that many companies deal with, and our solution does not give us a competitive advantage over those other companies, we are probably better off using an off-the-shelf product, whether that is a commercial (COTS) product, or a Free or Open-Source one (FOSS). Software we build should be unique to the company it is being built for, and provide that company with a competitive advantage. There is no need for us to build another Customer Relationship Manager (CRM) or Accounting system since these systems implement solutions to solved problemns that are generally solved in the same way by everyone. We should only build custom solutions if we are doing something that has never been done before or we need to do things in a way that is different from everyone else and can't be done using off-the-shelf systems.

We should also only be building custom software when the problem being solved is part of our company's [core competencies](https://en.wikipedia.org/wiki/Core_competency "A combination of multiple resources and skills that distinguish a firm in the marketplace and therefore are the foundation of companies' competitiveness"). If we are doing this work for a company that builds widgets, it is unlikely, though not impossible, that building a custom solution for getting parts needed to build the widgets will provide that company with a competitive advantage. We are probably better off if we focus our efforts on software to help make the widgets in ways that are better, faster or cheaper.

If our "build vs. buy" decision is to build a custom solution, there are likely to be opportunities within those systems to use pre-existing capabilities rather than writing everything from scratch. For example, many cross-cutting concerns within our applications have libraries that support them very effectively. We should not be coding our own implementations for things like [logging](https://en.wikipedia.org/wiki/Logging_(computing) "The act of keeping a log of events that occur in a computer system, such as problems, errors or just information on current operation"), [configuration](https://en.wikipedia.org/wiki/Computer_configuration "The arrangement of a system's functional units according to their nature, number and chief characteristics") and [security](https://en.wikipedia.org/wiki/Security "Protection from or resilience against, potential harm (or other unwanted coercive change) caused by others, by restraining the freedom of others to act"). Likewise, there are many capabilities that already exist in our infrastructure that we should take advantage of. [Encryption](https://en.wikipedia.org/wiki/Encryption "The process of encoding information"), which is often a capability of the operating system, is one that springs to mind. We should certainly never "roll-our-own" for more complex infrastructure features like [Replication](https://en.wikipedia.org/wiki/Replication_(computing) "Sharing information so as to ensure consistency between redundant resources, such as software or hardware components, to improve reliability, fault-tolerance, or accessibility.") or [Change Data Capture](https://en.wikipedia.org/wiki/Change_data_capture "CDC is a set of software design patterns used to determine and track the data that has changed so that action can be taken using the changed data."), but might even want to consider avoiding rebuilding infrastructure capabilities that we more commonly build. An example of this might be if we would typically build a [Web API](https://en.wikipedia.org/wiki/Web_API "An Application Programming Interface exposed over HTTP(S)") for our systems, we might consider exposing the API's of our backing infrastructure components instead, properly isolated and secured of course, perhaps via an [API Management](https://en.wikipedia.org/wiki/API_management "The process of creating and publishing web application programming interfaces (APIs), enforcing their usage policies, controlling access, nurturing the subscriber community, collecting and analyzing usage statistics, and reporting on performance") component.

#### Goals of the Conversation

Development teams should have conversations around **Competencies** that are primarily focused around what systems, sub-systems, and components should be built, which should be installed off-the-shelf, and what libraries or infrastructure capabilities should be utilized. These conversations should include answering questions like:

* What are our core competencies?
* How do we identify "build vs. buy" opportunities?
* How do we make "build vs. buy" decisions on needed systems?
* How do we identify cross-cutting concerns and infrastructure capabilites that can be leveraged?
* How do we determine which libraries or infrastructure components will be utilized?
* How do we manage the versioning of utilized components, especially in regard to security updates?
* How do we document our decisions for later review?

#### Next Up - Coalescence

In the final article of this series we will look at {PostLink:critical-cs-of-microservices-6of6-coalescence|Coalescence} and how we should work to bring all of the data together for our operations & support engineers.
