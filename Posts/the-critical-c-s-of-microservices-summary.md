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
categories:
- Development
menuorder: 0
id: fbfe137c-b52a-4419-b282-c814296d9157
title: The Critical C's of Microservices
description: A series of conversations that development teams should have around building event driven or microservice architectures
ispublished: false
showinlist: false
publicationdate: 2023-01-23T07:00:00Z
lastmodificationdate: 2023-01-23T07:00:00Z
slug: critical-cs-of-microservices-summary

---
&quot;**The Critical C's of Microservices**&quot; are a series of conversations that development teams should have around building event-driven or other microservice based architectures. These topics will help teams determine which architectural patterns are best for them, and assist in building their systems and processes in a reliable and supportable way.

Each of these topics has been covered in detail in a series of 6 articles. These articles are linked below. Additionally, all of the sample questions for the conversations are listed together below for easy reference.

There is also a  [Critical C's of Microservices]({PathToRoot}/CriticalCs/index.html) website that includes the same information as in these articles. This site will be kept up-to-date as the guidance evolves.

#### Links to the articles

1. {PostLink:critical-cs-of-microservices-1of6-context|Context}
1. {PostLink:critical-cs-of-microservices-2of6-consistency|Consistency}
1. {PostLink:critical-cs-of-microservices-3of6-contract|Contract}
1. {PostLink:critical-cs-of-microservices-4of6-chaos|Chaos}
1. {PostLink:critical-cs-of-microservices-5of6-competencies|Competencies}
1. {PostLink:critical-cs-of-microservices-6of6-coalescence|Coalescence}

#### Summaries of Questions

##### Context

Development teams should have conversations around **Context** that are primarily focused around the tools and techniques that they intend to use to avoid the Dual-Writes Anti-Pattern. These conversations should include answering questions like:

* What database technologies will we use and how can we leverage these tools to create downstream events based on changes to the database state?
* Which of our services are currently idempotent and which ones could reasonably made so? How can we leverage our idempotent services to improve system reliability?
* Do we have any services right now that contain business processes implemented in a less-reliable way? If so, pulling this functionality out into their own microservices might be a good starting point for decomposition.
* What processes will we as a development team implement to track and manage the technical debt of having business processes implemented in a less-reliable way?
* What processes will we implement to be sure that any future less-reliable implementations of business functionality are made with consideration and understanding of the debt being created and a plan to pay it off.
* What processes will we implement to be sure that any existing or future less-reliable implementations of business functionality are documented, understood by, and prioritized by the business process owners.

##### Consistency

Development teams should have conversations around **Consistency** that are primarily focused around making certain that the system is assumed to be eventually consistency throughout. These conversations should include answering questions like:

* What patterns and tools will we use to create systems that support reliable, eventually consistent operations?
* How will we identify existing areas where higher-levels of consistency have been wedged-in and should be removed?
* How will we prevent future demands for higher-levels of consistency, either explicit or assumed, to creep in to our systems?
* How will we identify when there are unusual or unacceptable delays in the system reaching a consistent state?
* How will we communicate the status of the system and any delays in reaching a consistent state to the relevant stakeholders?

##### Contract

Development teams should have conversations around **Contract** that are primarily focused around creating processes that define any integration contracts for both upstream and downstream services, and serve to defend their internal data representations against any external consumers. These conversations should include answering questions like:

* How will we isolate our internal data representations from those of our downstream consumers?
* What types of compatibility guarantees are our tools and practices capable of providing?
* What procedures should we have in place to monitor incoming and outgoing contracts for compatibility?
* What should our procedures look like for making a change to a stream that has downstream consumers?
* How can we leverage upstream messaging contracts to further reduce the coupling of our systems to our upstream dependencies?

##### Chaos

Development teams should have conversations around **Chaos** that are primarily focused around procedures for identifying and remediating possible failure points in the application. These conversations should include answering questions like:

* How will we evaluate potential sources of failures in our systems before they are built?
  * How will we handle the inability to reach a dependency such as a database?
  * How will we handle duplicate messages sent from our upstream data sources?
  * How will we handle messages sent out-of-order from our upstream data sources?
* How will we expose possible sources of failures during any pre-deployment testing?
* How will we expose possible sources of failures in the production environment before they occur for users?
* How will we identify errors that occur for users within production?
* How will we prioritize changes to the system based on the results of these experiments?

##### Competencies

Development teams should have conversations around **Competencies** that are primarily focused around what systems, sub-systems, and components should be built, which should be installed off-the-shelf, and what libraries or infrastructure capabilities should be utilized. These conversations should include answering questions like:

* What are our core competencies?
* How do we identify "build vs. buy" opportunities?
* How do we make "build vs. buy" decisions on needed systems?
* How do we identify cross-cutting concerns and infrastructure capabilites that can be leveraged?
* How do we determine which libraries or infrastructure components will be utilized?
* How do we manage the versioning of utilized components, especially in regard to security updates?
* How do we document our decisions for later review?

##### Coalescence

Development teams should have conversations around **Coalescence** that are primarily focused around brining critical information about the operation of our systems together for easy acess. These conversations should include answering questions like:

* What is our mechanism for deployment and system verification?
  * How will we identify, as quickly as possible, when a deployment has had a negative impact on our system?
  * Are there tests that can validate the operation of the system end-to-end?
  * How will we surface the status of any deployment and system verification tests? 
* What is our mechanism for logging/traceability within our system?
  * How will we coalesce our logs from the various services within the system?
  * How will we know if there are anomalies in our logs?
  * Are there additional identifiers we need to add to allow traceability?
  * Are there log queries that, if enabled, might provide additional support during an outage?
  * Are there ways to increase the level of logging when needed to provide additional information and can this be done wholistically on the system?
*  How will we expose SLIs and other metrics so they are available when needed?
  * How will we know when there are anomalies in our metrics?
  * What are the metrics that would be needed in an outage and how will we surface those for easy access?
  * Are there additional metrics that, if enabled, might provide additional support during an outage?
  * Are there ways to perform ad-hoc queries against SLIs and metrics to provide additional insight in an outage?
* How will we identify the status of dependencies so we can understand when our systems are reacting to downstream anomalies?
  * How will we surface dependency status for easy access during an outage?
  * Are there metrics we can surface for our dependencies that might help during an outage?
