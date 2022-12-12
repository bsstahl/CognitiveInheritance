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
id: d4b58b20-d4d7-4234-a828-4563d68db564
title: The Critical C's of Microservices - Contract
description: A series of conversations that development teams should have around building event driven or microservice architectures
ispublished: false
showinlist: false
publicationdate: 2022-12-13T07:00:00Z
lastmodificationdate: 2022-12-13T07:00:00Z
slug: critical-cs-of-microservices-3of6-contract

---
&quot;**The Critical C's of Microservices**&quot; are a series of conversations that development teams should have prior to building event-driven or other microservice based architectures. These topics will help teams determine which architectural patterns are best for them, and assist in building the systems and processes in a reliable and supportable way.

The &quot;Critical C's&quot; are: **Context**, **Consistency**, **Contract**, **Chaos**, **Competencies** and **Coalescence**. Each of these topics will be covered in detail in this series of articles. This is article 3 of the 6, and covers the topic of **Contract**.

#### Contract

Once a message has been defined and agreed to as an integration mechanism, all stakeholders in that integration have an expectation of the agreed on level of compatibility. This guarantee will often be such that messages can add fields as needed, but cannot remove, move, or change the nature of existing fields without significant coordination with the stakeholders. This can have a severe impact on the **agility** of our dev teams as they try to move fast and iterate with their designs.

In order to keep implementations flexible, there should be an isolation layer between the internal representation (Domain Model) of any message, and the more public (Integration Model) representation. This way, the developers can change the internal representation with only limited restrictions, so long as as the message remains transformationally compatible with the integration message, and the transformation is modified as needed so that no change is seen by the integration consumers. The representations may take different forms, the important thing is that the developers can iterate quickly on the internal representation when needed. The **Eventually Consistent** example in the diagram above shows such a isolation layer since the *WorkOrders DB* holds the internal representation of the message, the *Kafka Connect* connector is the abstraction that performs the transformation as needed, and the topic that the connector produces data to is the integration path.

We need to take great care to defend these internal streams. Ideally, only 1 service should ever write to our domain model, and only internal services, owned by the same small development team, should read from it. As soon as we allow other teams into our domain model, it becomes an integration model whether we want it to be or not.

Similarly, our services should make proper use of upstream integration models. We need to understand what level of compatibility we can expect and how we will be notified of changes. We should use these data paths as much as possible to bring external data locally to our services, in exactly the form that our service needs it in, so that each of our services can own its own data for both reliability and efficiency. Of course, these local stores must be read-only. We need to publish change requests back to the *System of Record* to make any changes to data sourced by those systems.

#### Next Up - Chaos

In the next article of this series we will look at **Chaos** and how we can use thought experiments and existing tools to help improve our system's reliability.
