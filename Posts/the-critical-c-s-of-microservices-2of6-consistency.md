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
categories: [ ]
menuorder: 0
id: 86685931-2951-4253-a923-563537481cee
title: The Critical C's of Microservices - Consistency
description: A series of conversations that development teams should have around building event driven or microservice architectures
ispublished: false
showinlist: false
publicationdate: 2022-12-13T07:00:00Z
lastmodificationdate: 2022-12-13T07:00:00Z
slug: critical-cs-of-microservices-2of6-consistency

---
&quot;**The Critical C's of Microservices**&quot; are a series of conversations that development teams should have prior to building event-driven or other microservice based architectures. These topics will help teams determine which architectural patterns are best for them, and assist in building the systems and processes in a reliable and supportable way.

The &quot;Critical C's&quot; are: **Context**, **Consistency**, **Contract**, **Chaos**, **Competencies** and **Coalescence**. Each of these topics will be covered in detail in this series of articles. This is article 2 of the 6, and covers the topic of **Consistency**.

#### Consistency

The world is eventually consistent. The sooner we get that through our heads and start expecting our systems to act like it, the fewer problems, we will have. In fact, I'll go out on a limb and say that most of the problems in building and maintaining microservice architectures are the result of failing to fully embrace eventual consistency from the start.

Data is consistent when it appears the same way when viewed from multiple perspectives. Our systems are said to be consistent when all of the data them is consistent. A system with strong consistency guarantees would be one where every actor, anywhere in the context of the application, would see the exact same value for any data element at any given time. A system that is *eventually consistent* is one with strong guarantees that the data will reach all intended targets, but much weaker guarantees about how long it might take to achieve data consistency.



Full consistency is impossible in a world where there is a finite speed of causation. Strong consistency is extremely difficult unless all of the data is housed in a single, ACID compliant data store, which of course, is a very bad idea when building scalable systems. Strong consistency, or anything more stringent than eventual consistency, may be appropriate when geo-replicating data stores (assuming the database server is designed for such a thing), but should not be implemented inside an application.

We should challenge demands for higher levels of consistency with rigor. Attempts to provide stronger consistency guarantees than *eventual* will cause far more problems than they are worth.

We will always need to look for situations where consistency problems might occur (i.e. race-conditions), expect them to happen, and try to design our systems in such a way as to not need to worry about them. Race conditions and other consistency problems are a smell. If you are in a situation where you are might see these types of problems, it may indicate that you need to reevaluate the details of your implementation.

As an example, let's take a look at the 3 implementation diagrams below. In all 3 of these implementations, the goal is to have the WorkOrder service modify a WorkOrder and have the changes published onto a topic for downstream consumers. If a WorkOrder already exists, it needs to be loaded from the data store so that appropriate updates can be made. As you will see, the 3 implementations have very different reliability characteristics.

{ImageLink:CTP%20Pattern%20-%20Race%20Condition.png|3 Possible Implementations - Entity updated and published}

* **Implementation 1 - Dual-Write**: In the 1st example, the WorkOrder service attempts to both update the entity in the database, and publish the changes to the topic for downstream consumers. This is probably an attempt to keep both the event and the update consistent with one another. However, since it is impossible to make more than 1 reliable change at a time, the only way this implementation can guarantee reliability is if the DB updates are done 1st, and in an idempotent way. If that is the case, in the circumstances where the publish fails, the service can roll the command message back onto the original topic and try the entire change again. Notice however that this doesn't guarantee consistency at all. In this failure path, the DB is updated before the publication ever occurs. Attempting to use a DB transaction to maintain consistency actually makes the problem worse for reasons that are outside of the scope of this discussion. Only a distributed transaction across the database and topic would accomplish that, and would do so at the expense of system scalability.

* **Implementation 2 - Race Condition**: In the 2nd example, the WorkOrder service gets data from the DB, and uses that to publish any needed updates to the topic. The topic is then used to feed the database, as well as any additional downstream consumers. While it might seem like it would be obvious that a race-condition could occur here, it is not uncommon to miss this kind of implementation in a more complicated environment. It also can be tempting, if the original implementation did not involve updating the DB, to use the topic to supply data for that update rather than making the more complicated change of moving the DB inline prior to the topic (option 3 below). Be aware of these types of possible race-conditions and be willing to make the correct changes as needed to protect your reliability when demands change.

* **Implementation 3 - Eventually Consistent**: In the 3rd example, the DB is used directly by both the WorkOrder service, and as the source of changes to the topic. This scenario is reliable but only eventually consistent. That is, we know that both the DB and the topic will be updated since the WorkOrder service makes the DB update directly, and the reliable change feed from the DB instantiates a new execution context for the topic to be updated. This way, there is only a single change to system state made within an execution context, and we can know that they will happen reliably.

Another example of a consistency smell might be when end-users insist that their UI should not return after they update something in an app, until the data is guaranteed to be consistent. I don't blame users for making these requests. After all, we trained them that the way to be sure that a system is reliable is to hit refresh until they see the data. In this situation, assuming we can't talk the users out of it, our best path is to make the UI wait until our polling, or a notification mechanism, identifies that the data is now consistent. I think this is a pretty rude thing to do to our users, but if they insist on it, I can only advise them against it. I will not destroy the scalability of systems I design, and add complexity to these systems that the developers will need to maintain forever, by simulating consistency deeper inside the app. The internals of the application should be considered eventually consistent at all times and we need to get used to thinking about it in this way.

#### Next Up - Contract

In the next article of this series we will look at **Contract** and how we can leverage contracts to make our systems more reliable while still maintaining our agility.
