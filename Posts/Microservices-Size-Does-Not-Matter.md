---
tags:
- architecture
- coding-practices
- event-driven
- microservices
- reliability
- resiliency
- soa
menuorder: 0
id: 53e0a79d-1096-4874-9639-6c1fb3eb8b47
author: bsstahl
title: Microservices&colon; Size Doesn&apos;t Matter, Reliability Does
description: The number and size of microservices is irrelevant as long as they are reliable
ispublished: false
showinlist: false
publicationdate: 2023-02-20T07:00:00.000+00:00
lastmodificationdate: 2023-02-20T07:00:00.000+00:00
slug: microservices-size-does-not-matter
categories:
- Development

---
If you are building a distributed system using microservices, you may have heard some conflicting opinions about how many microservices you should have, or the size of those services. Some people may say that you have too many microservices, and that you should consolidate them into fewer, larger services to reduce deployment and operational complexity. Others may say that you don't have enough microservices, and that you should break them down into smaller, more granular services. Aside from the always true and rarely helpful "it depends...", is there good guidance on the subject?

The fact is, the number of microservices you have is not a measure of quality or performance unto itself. It is a design decision based on one simple characteristic, **Reliability**. As such, there is a simple rule guiding the creation of services, but it isn't based on the size or quantity of services. It is based entirely on how much work a service does.

After security, reliability is the most important attribute of any system, because it affects the satisfaction of both the users and developers, as well as the productivity and agility of the development team. A reliable system is one that works as expected, with minimal errors, failures, or downtime, and recovers itself automatically when outages do occur, without data loss. Having reliable systems means that your support engineers won't be constantly woken-up in the middle of the night to deal with outages, and your customers will remain satisfied with the quality of the product.

How do you achieve reliability with microservices? By following one simple rule: **avoid dual-writes**. A dual-write is when a microservice makes more than one change to system state within an execution context. For example, a web API that updates a database and sends a message to a queue during the execution of a single web request is performing a dual-write since it is making two different changes to the state of the system. Dual-writes are the enemy of reliability, because they create the risk of inconsistency, data loss, and data corruption. If one of the writes succeeds and the other fails, the system state becomes out of sync and system behavior becomes unpredictable. The errors these types of failures create are often hard to find and remediate because they often present very differently depending on when the failure occurred. The best-practice is clear, microservices can read data as often as they need, but should only write data once. An **atomic update** to a database is an example of such a write, regardless of how many tables or collections are updated during that process. This is how we can keep the state of each service consistent, and the system behavior deterministic. If the process fails even part-way through, we know how to recover, and can often do it automatically.

Building this type of system does require a change in how we design our services. In the past, it was very common for us to make multiple state changes to a system's state, especially inside a monolithic application. To remain reliable, we need to leverage tools like Change Data Capture (CDC) available in most modern database systems, so that we can write our data once, and have that update trigger other activities downstream.

Since microservices are sized to avoid dual-writes, the number of microservices in a system is determined by what they do and how they interact. The number of microservices is not a fixed or arbitrary number, but a result of the system design and the business needs. By following the rule of avoiding dual-writes, you can size your microservices appropriately, and achieve a system that is scalable and adaptable, but most of all, reliable.
