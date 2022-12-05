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
id: 51de4c4b-3382-4971-a64b-57e31638d15e
title: The Critical C's of Microservices
description: A series of keys that should always be evaluated when building, operating
  and deploying microservice based architectures
ispublished: false
showinlist: false
publicationdate: 2022-12-12T07:00:00Z
lastmodificationdate: 2022-12-12T07:00:00Z
slug: critical-cs-of-microservices

---
In the process of designing and building microservices and event-driven architectures, I've noticed that many of my recommendations on the subject can be summarized under a heading that starts with the letter &quot;C&quot;: **Context**, **Consistency**, **Contract**, **Chaos**, **Competencies** and **Coalesce**. I have chosen to group these recommendations under the moniker, &quot;**The Critical C's of Microservices**&quot; and will discuss each of them in detail.

#### Context

The **execution context** is the unit of work of all services. It represents the life-cycle of a single request, regardless of the details of how that request was received. So, whether an HTTP web request, or an asynchronous message from Kafka or Service Bus, the context we care about here is the processing of that message within the request. Since, as it turns out, there is no way to reliably make more than one change to system state within a single execution context, we must defend this context in order to maintain the reliability of our services.

There are generally only two situations where it is ok to make more than one change to system state in a single execution context:

1. When the first change is [idempotent](https://en.wikipedia.org/wiki/Idempotence "Idempotence is the ability to execute a task an arbitrary number of times (>1) and have the resulting state of the system be the same as if the task was executed once.") so we can rollback the message and try again later without bad things happening due to duplication. An example of this is a database **Upsert** where all of the data, including keys, is supplied. In this case, the 1st time we execute the request, we might insert the record in the DB. If a later change fails in the same context and we are resent the same message, the resulting update using the same data will leave in the same state as if the request was only executed once. Since this operation can be executed as many times as necessary, without impacting the ultimate state of the system, we can make other changes after this one and still rollback and retry the request if a subsequent operation fails, without damaging the system. Services that are Idempotent are much easier to orchestrate reliably, so much so that Idempotence is considered a highly-desireable feature of microservices.

1. When the second change is unreliable. An example of this is logging. We don't want to fail a business-process due to failures in logging, so we accept that our logging, and certain other technical processes, may be less-reliable than our business processes. It is **rarely** ok for a business process to be less-reliable in this way. Implementations that make certain business features less-reliable should be identified, documented, and discussed with an eye toward repaying what is likely to be technical debt.

Ultimately, to maintain the reliability of our systems, we must defend the execution context at all costs.

#### Consistency

The world is eventually consistent. The sooner we get that through our heads and start expecting our systems to act like it, the fewer problems, we will have. In fact, I'll go out on a limb and say that most of the problems in building and maintaining microservice architectures are the result of failing to fully embrace eventual consistency from the start.

Challenge demands for higher levels of consistency with rigor. Full consistency is impossible in a world where the speed of causation is not infinite. Strong consistency is extremely difficult unless all of the data is housed in a single, ACID compliant data store, which is of course, a very bad idea when building scalable systems. Strong consistency, or anything more stringent than eventual consistency, may be appropriate when geo-replicating data stores (assuming the database server is designed for such a thing), but should not be implemented inside an application. Attempts to provide stronger consistency guarantees than *eventual* will cause far more problems than they are worth.

We will always need to look for situations where consistency problems might occur (i.e. race-conditions), expect them to happen, and try to design our systems in such a way as to not need to worry about them. Race conditions and other consistency problems are a smell. If you are in a situation where you are might see these types of problems, it may indicate that you need to reevaluate the details of your implementation.

As an example, let's take a look at the 3 implementation diagrams below. In all 3 of these implementations, the goal is to have the WorkOrder service modify a WorkOrder and have the changes published onto a topic for downstream consumers. If a WorkOrder already exists, it needs to be loaded from the data store so that appropriate updates can be made. As you will see, the 3 implementations have very different reliability characteristics.

{ImageLink:CTP%20Pattern%20-%20Race%20Condition.png|3 Possible Implementations - Entity updated and published}

* **Implementation 1 - Dual-Write**: In the 1st example, the WorkOrder service attempts to both update the entity in the database, and publish the changes to the topic for downstream consumers. This is probably an attempt to keep both the event and the update consistent with one another. However, since it is impossible to make more than 1 reliable change at a time, the only way this implementation can guarantee reliability is if the DB updates are done 1st, and in an idempotent way. If that is the case, in the circumstances where the publish fails, the service can roll the command message back onto the original topic and try the entire change again. Notice however that this doesn't guarantee consistency at all. In this failure path, the DB is updated before the publication ever occurs. Attempting to use a DB transaction to maintain consistency actually makes the problem worse for reasons that are outside of the scope of this discussion. Only a distributed transaction across the database and topic would accomplish that, and would do so at the expense of system scalability.

* **Implementation 2 - Race Condition**: In the 2nd example, the WorkOrder service gets data from the DB, and uses that to publish any needed updates to the topic. The topic is then used to feed the database, as well as any additional downstream consumers. While it might seem like it would be obvious that a race-condition could occur here, it is not uncommon to miss this kind of implementation in a more complicated environment. It also can be tempting, if the original implementation did not involve updating the DB, to use the topic to supply data for that update rather than making the more complicated change of moving the DB inline prior to the topic (option 3 below). Be aware of these types of possible race-conditions and be willing to make the correct changes as needed to protect your reliability when demands change.

* **Implementation 3 - Eventually Consistent**: In the 3rd example, the DB is used directly by both the WorkOrder service, and as the source of changes to the topic. This scenario is reliable but only eventually consistent. That is, we know that both the DB and the topic will be updated since the WorkOrder service makes the DB update directly, and the reliable change feed from the DB instantiates a new execution context for the topic to be updated. This way, there is only a single change to system state made within an execution context, and we can know that they will happen reliably.

Another example of a consistency smell might be when end-users insist that their UI should not return after they update something in an app, until the data is guaranteed to be consistent. I don't blame users for making these requests. After all, we trained them that the way to be sure that a system is reliable is to hit refresh until they see the data. In this situation, assuming we can't talk the users out of it, our best path is to make the UI wait until our polling, or a notification mechanism, identifies that the data is now consistent. I think this is a pretty rude thing to do to our users, but if they insist on it, I can only advise them against it. I will not destroy the scalability of systems I design, and add complexity to these systems that the developers will need to maintain forever, by simulating consistency deeper inside the app. The internals of the application should be considered eventually consistent at all times and we need to get used to thinking about it in this way.

#### Contract

Once a message has been defined and agreed to as an integration mechanism, all stakeholders in that integration have an expectation of the agreed on level of compatibility. This guarantee will often be such that messages can add fields as needed, but cannot remove, move, or change the nature of existing fields without significant coordination with the stakeholders. This can have a severe impact on the **agility** of our dev teams as they try to move fast and iterate with their designs.

In order to keep implementations flexible, there should be an isolation layer between the internal representation (Domain Model) of any message, and the more public (Integration Model) representation. This way, the developers can change the internal representation with only limited restrictions, so long as as the message remains transformationally compatible with the integration message, and the transformation is modified as needed so that no change is seen by the integration consumers. The representations may take different forms, the important thing is that the developers can iterate quickly on the internal representation when needed. The **Eventually Consistent** example in the diagram above shows such a isolation layer since the *WorkOrders DB* holds the internal representation of the message, the *Kafka Connect* connector is the abstraction that performs the transformation as needed, and the topic that the connector produces data to is the integration path.

We need to take great care to defend these internal streams. Ideally, only 1 service should ever write to our domain model, and only internal services, owned by the same small development team, should read from it. As soon as we allow other teams into our domain model, it becomes an integration model whether we want it to be or not.

Similarly, our services should make proper use of upstream integration models. We need to understand what level of compatibility we can expect and how we will be notified of changes. We should use these data paths as much as possible to bring external data locally to our services, in exactly the form that our service needs it in, so that each of our services can own its own data for both reliability and efficiency. Of course, these local stores must be read-only. We need to publish change requests back to the *System of Record* to make any changes to data sourced by those systems.

#### Chaos

One of the [Fallacies of distributed computing](https://en.wikipedia.org/wiki/Fallacies_of_distributed_computing) is that the network is reliable. We should have similar expectations, or lack thereof, for the reliability of all of the infrastructure on which our services are run. Networks will segment, commodity servers and drives will fail, containers and operating systems will become unstable. In other words, our software will have errors during operation, no matter how resilient we attempt to make it. We need to embrace the fact that failures will occur in our software, and will do so at random times and often in unpredictable ways. 

If we are to build systems that don't require our constant attention, especially during off-hours, we need to be able to identify what happens when failures occur, and design our systems in ways that will allow them to heal automatically once the problem is corrected.

To start this process, I recommend playing "what-if" games using diagrams of the system. Walk through the components of the system, and how the data flows through it, identifying each place where failure could occur. Then, in each area where failures could happen, attempt to define the failure mode by determining what the impact of those failures might be. This kind of "virtual" Chaos Engineering is certainly no substitute for actual experimentation and testing, but is a good starting point for more in-depth analysis.

Thought experiments are useful, but you cannot really know how a system will respond to different types of failures until you have those failures in production. Historically, such "tests" have occured at random, at the whim of the infrastructure, and usually at the worst possible time. Instead of leaving these things to chance, tools like *Chaos Monkey* can be used to simulate failures in production, and can be set to occur during times where the appropriate support engineers are available and ready to respond if necessary. This way, we can see if our systems respond as we expect, and more importantly, heal themselves as we expect.

Even if you're not ready to jump into using automated experimentation tools in production just yet, a lot can be learned from using feature-flags and changing service behaviors in a more controlled manor to start. This might involve a flag that can be set to cause an API method to return an error response, either as a hard failure, or during random requests for a period of time. Perhaps a switch could be set to stop a service from picking-up asynchronous messages from a queue or topic. Of course, these flags can only be placed in code we control, so we can't test failures of dependencies like databases and other infrastructure components in this way. For that, we'll need more involved testing methods.

Regardless of how we test our systems, it is important that we do everything we can to build systems that will heal themselves without the need for us to intervene every tinme a failure occurs. As a result, I highly recommend using asynchronous messaging patterns whenever possible. The asynchrony of these tools allow our services to be "temporally decoupled" from their dependencies. As a result, if a container fails and is restarted by Kubernetes, any message in process is rolled-back onto the queue or topic, and the system can pick right up where it left off.

#### Competencies

#### Coalescence

