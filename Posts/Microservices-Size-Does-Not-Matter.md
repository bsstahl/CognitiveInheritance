---
tags:
- architecture
- coding-practices
- event-driven
- microservices
- reliability
- soa
menuorder: 0
id: 53e0a79d-1096-4874-9639-6c1fb3eb8b47
author: bsstahl
title: Microservices&colon; Size Doesn&apos;t Matter, Reliability Does
description: The number and size of microservices is irrelevant as long as they are reliable
ispublished: false
buildifnotpublished: true
showinlist: false
publicationdate: 2023-02-20T07:00:00.000+00:00
lastmodificationdate: 2023-02-20T07:00:00.000+00:00
slug: microservices-size-does-not-matter
categories:
- Development

---
There are conflicting opinions among architects about how many microservices a distributed system should have, and the size of those services. Some people may say that a particular design has too many microservices, and that it should be consolidated into fewer, larger services to reduce deployment and operational complexity. Others may say that the same design doesn't have enough microservices, and that it should be broken-down into smaller, more granular services to reduce internal complexity. Aside from the always true and rarely helpful "it depends...", is there good guidance on the subject?

The truth is, the number and size of microservices is not a measure of quality or performance unto itself, it is a design decision based on one primary characteristic, **Reliability**. As such, there is a simple rule guiding the creation of services, but it isn't based on the size or quantity of services. The rule is based entirely on how much work a service does.

After security, reliability is the most important attribute of any system, because it affects the satisfaction of both the users and developers, as well as the productivity and agility of the development and support teams. A reliable system has the following characteristics:

* It performs its duties as expected
* It has minimal failures where it has to report to the user that it is unable to perform its duties
* It has minimal downtime when it cannot be reached and opportunities may be lost
* It recovers itself automatically when outages do occur, without data loss

Having reliable systems means that your support engineers won't be constantly woken-up in the middle of the night to deal with outages, and your customers will remain satisfied with the quality of the product.

#### How do we build reliable systems with microservices?

To build a reliable system using microservices, we need to follow one simple rule: **avoid dual-writes**. A dual-write is when a service makes more than one change to system state within an execution context. For example, a web API that updates a database and sends a message to a queue during the execution of a single web request is performing a dual-write since it is making two different changes to the state of the system, and both of the changes are expected to occur reliably. Dual-writes are the enemy of reliability, because they create the risk of inconsistency, data loss, and data corruption. If one of the writes succeeds and the other fails, the system state becomes out of sync and system behavior becomes unpredictable. The errors these types of failures create are often hard to find and remediate because they usually present very differently depending on when the failure occurred. The best-practice is clear, microservices can read data as often as they need, but should only write data once. An **atomic update** to a database is an example of such a write, regardless of how many tables or collections are updated during that process. In this way, we can keep the state of each service consistent, and the system behavior deterministic. If the process fails even part-way through, we know how to recover, and can often do it automatically.

Building this type of system does require a change in how we design our services. In the past, it was very common for us to make multiple state changes to a system's state, especially inside a monolithic application. To remain reliable, we need to leverage tools like [Change Data Capture (CDC)](https://en.wikipedia.org/wiki/Change_data_capture "Events created by a database system when data updates occur that can reliably trigger downstream actions"), which is available in most modern database systems, or the [Transactional Outbox Pattern](https://learn.microsoft.com/en-us/azure/architecture/best-practices/transactional-outbox-cosmos "Reliably update a data store AND take additional downstream action by atomically writing 2 updates to the data store, the state update, and an event that is monitored for by another system and used to take the additional action") so that we can write our data once, and have that update trigger other activities downstream.

Since microservices are sized to avoid dual-writes, the number of microservices in a system is determined by what they do and how they interact. The number of microservices is not a fixed or arbitrary number, but a result of the system design and the business needs. By following the rule of avoiding dual-writes, you can size your microservices appropriately, and achieve a system that is scalable and adaptable, but most of all, reliable.

For more detail on how to avoid the Dual-Writes Anti-Pattern, please see my article from December 2022 on {PostLink:critical-cs-of-microservices-1of6-context|The Execution Context}.
