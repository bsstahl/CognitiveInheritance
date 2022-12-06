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
categories: []
menuorder: 0
id: 082c3f8a-ac4a-4231-9962-01536167e4a5
title: The Critical C's of Microservices
description: A series of conversations that development teams should have prior to building event driven or microservice architectures
ispublished: false
showinlist: false
publicationdate: 2022-12-12T07:00:00Z
lastmodificationdate: 2022-12-12T07:00:00Z
slug: critical-cs-of-microservices-1of6-context

---
&quot;*The Critical C's of Microservices*&quot; are a series of conversations that development teams should have prior to building event driven or microservice architectures. These topics will help teams determine which architectural patterns are best for them, and assist in building the systems and processes in a reliable and supportable way.

The &quot;Critical C's&quot; are: **Context**, **Consistency**, **Contract**, **Chaos**, **Competencies** and **Coalescence**. Each of these topics will be covered in detail in this series of articles, starting with **Context**.

#### Context

The **execution context** is the unit of work of all services. It represents the life-cycle of a single request, regardless of the details of how that request was received. So, whether an HTTP web request, or an asynchronous message from Kafka or Service Bus, the context we care about here is the processing of that message within the request. Since, as it turns out, there is no way to reliably make more than one change to system state within a single execution context, we must defend this context in order to maintain the reliability of our services.

There are generally only two situations where it is ok to make more than one change to system state in a single execution context:

1. When the first change is [idempotent](https://en.wikipedia.org/wiki/Idempotence "Idempotence is the ability to execute a task an arbitrary number of times (>1) and have the resulting state of the system be the same as if the task was executed once.") so we can rollback the message and try again later without bad things happening due to duplication. An example of this is a database **Upsert** where all of the data, including keys, is supplied. In this case, the 1st time we execute the request, we might insert the record in the DB. If a later change fails in the same context and we are resent the same message, the resulting update using the same data will leave in the same state as if the request was only executed once. Since this operation can be executed as many times as necessary, without impacting the ultimate state of the system, we can make other changes after this one and still rollback and retry the request if a subsequent operation fails, without damaging the system. Services that are Idempotent are much easier to orchestrate reliably, so much so that Idempotence is considered a highly-desireable feature of microservices.

1. When the second change is unreliable. An example of this is logging. We don't want to fail a business-process due to failures in logging, so we accept that our logging, and certain other technical processes, may be less-reliable than our business processes. It is **rarely** ok for a business process to be less-reliable in this way. Implementations that make certain business features less-reliable should be identified, documented, and discussed with an eye toward repaying what is likely to be technical debt.

Ultimately, to maintain the reliability of our systems, we must defend the execution context at all costs.
