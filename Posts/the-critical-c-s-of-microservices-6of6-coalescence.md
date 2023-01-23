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
id: a0280db3-6d32-4c89-81c4-10ce2cd3522d
title: The Critical C's of Microservices - Coalescence
description: A series of conversations that development teams should have around building event driven or microservice architectures
ispublished: true
showinlist: false
publicationdate: 2023-01-16T07:00:00Z
lastmodificationdate: 2023-01-16T07:00:00Z
slug: critical-cs-of-microservices-6of6-coalescence

---
&quot;**The Critical C's of Microservices**&quot; are a series of conversations that development teams should have around building event-driven or other microservice based architectures. These topics will help teams determine which architectural patterns are best for them, and assist in building their systems and processes in a reliable and supportable way.

The &quot;Critical C's&quot; are: **Context**, **Consistency**, **Contract**, **Chaos**, **Competencies** and **Coalescence**. Each of these topics has been covered in detail in this series of 6 articles. The first article of the 6 was on the subject of {PostLink:critical-cs-of-microservices-1of6-context|Context}. This is the final article in the series, and covers the topic of **Coalescence**.

#### Coalescence

The use of Microservices reduces the complexity of our services in many ways, however it also adds complexity when it comes to deployment and operations. More services mean more deployments, even as each of those deployments is smaller and more isolated. Additionally, they can be harder on operations and support teams since there can be many more places to go when you need to find information. Ideally, we would coalesce all of the necessary information to operate and troubleshoot our systems in a single pane-of-glass so that our operations and support engineers don't have to search for information in a crisis.

Deployment and system verification testing can help us identify when there are problems at any point in our system and give us insight into what the problems might be and what caused them. Tests run immediately after any deployment can help identify when a particular deployment has caused a problem so it can be addressed quickly. Likewise, ongoing system verification tests can give early indications of problems irrespective of the cause. Getting information about the results of these tests quickly and easily into the hands of the engineers that can act on them can reduce costs and prevent outages.

Logging and traceability is generally considered a solved problem, so long as it is used effectively. We need to setup our systems to make the best use of our distributed logging systems. This often means adding a correlation identifier alongside various request and causation ids to make it easy to trace requests through the system. We also need to be able to monitor and surface our logs so that unusual activity can be recognized and acted on as quickly as possible.

Service Level Indicators (SLIs) and other metrics can provide key insights into the operations of our systems, even if no unusual activity is seen within our logs. Knowing what operational metrics suggest there might be problems within our systems, and monitoring changes to those metrics for both our services and our dependencies can help identify, troubleshoot and even prevent outages. Surfacing those metrics for easy access can give our support and operations engineers the tools they need to do their jobs effectively.

#### Goals of the Conversation

Development teams should have conversations around **Coalescence** that are primarily focused around brining critical information about the operation of our systems together for easy access. These conversations should include answering questions like:

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
