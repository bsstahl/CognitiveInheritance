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
id: d4b58b20-d4d7-4234-a828-4563d68db564
title: The Critical C's of Microservices - Contract
description: A series of conversations that development teams should have around building event driven or microservice architectures
ispublished: true
showinlist: false
publicationdate: 2022-12-26T07:00:00Z
lastmodificationdate: 2022-12-26T07:00:00Z
slug: critical-cs-of-microservices-3of6-contract

---
&quot;**The Critical C's of Microservices**&quot; are a series of conversations that development teams should have around building event-driven or other microservice based architectures. These topics will help teams determine which architectural patterns are best for them, and assist in building their systems and processes in a reliable and supportable way.

The &quot;Critical C's&quot; are: **Context**, **Consistency**, **Contract**, **Chaos**, **Competencies** and **Coalescence**. Each of these topics will be covered in detail in this series of articles. The first article of the 6 was on the subject of {PostLink:critical-cs-of-microservices-1of6-context|Context}. This is article 3 of the series, and covers the topic of **Contract**.

#### Contract

Once a message has been defined and agreed to as an integration mechanism, all stakeholders in that integration have legitimate expectations of that message contract. Primarily, these expectations includes the agreed-to level of compatibility of future messages, and what the process will be when the contract needs to change. These guarantees will often be such that messages can add fields as needed, but cannot remove, move, or change the nature of existing fields without significant coordination with the stakeholders. This can have a severe impact on the **agility** of our dev teams as they try to move fast and iterate with their designs.

In order to keep implementations flexible, there should be an isolation layer between the internal representation (Domain Model) of any message, and the more public representation (Integration Model). This way, the developers can change the internal representation with only limited restrictions, so long as as the message remains transformationally compatible with the integration message, and the transformation is modified as needed so that no change is seen by the integration consumers. The two representations may take different forms, such as one in a database, the other in a Kafka topic. The important thing is that the developers can iterate quickly on the internal representation when they need to.

{ImageLink:CTP%20Pattern%20-%20Eventually%20Consistent.png|Drawing showing 2 different representations of a WorkOrder in the same Workflow - 1 stored in the DB the other in Kafka}

The **Eventually Consistent** example from the earlier {PostLink:critical-cs-of-microservices-2of6-consistency|Consistency} topic (included above) shows such an isolation layer since the *WorkOrders DB* holds the internal representation of the message, the *Kafka Connect* connector is the abstraction that performs the transformation as needed, and the topic that the connector produces data to is the integration path. In this model, the development team can iterate on the model inside the DB without necessarily needing to make changes to the more public Kafka topic.

We need to take great care to defend these internal streams and keep them isolated. Ideally, only 1 service should ever write to our domain model, and only internal services, owned by the same small development team, should read from it. As soon as we allow other teams into our domain model, it becomes an integration model whether we want it to be or not. Even other internal services should use the public representation if it is reasonable to do so.

Similarly, our services should make proper use of upstream integration models. We need to understand what level of compatibility we can expect and how we will be notified of changes. We should use these data paths as much as possible to bring external data locally to our services, in exactly the form that our service needs it in, so that each of our services can own its own data for both reliability and efficiency. Of course, these local stores must be read-only. We need to publish change requests back to the *System of Record* to make any changes to data sourced by those systems.

We should also do everything we can to avoid making assumptions about data we don't own. Assuming a data type, particular provenance, or embedded-intelligence of a particular upstream data field will often cause problems in the future because we have created unnecessary coupling. As an example, it is good practice to treat all foreign identifiers as strings, even if they look like integers, and to never make assumptions along the lines of "...those identifiers will always be increasing in value". While these may be safe assumptions for a while, they should be avoided if they reasonably can be to prevent future problems.

#### Goals of the Conversation

Development teams should have conversations around **Contract** that are primarily focused around creating processes that define any integration contracts for both upstream and downstream services, and serve to defend their internal data representations against any external consumers. These conversations should include answering questions like:

* How will we isolate our internal data representations from those of our downstream consumers?
* What types of compatibility guarantees are our tools and practices capable of providing?
* What procedures should we have in place to monitor incoming and outgoing contracts for compatibility?
* What should our procedures look like for making a change to a stream that has downstream consumers?
* How can we leverage upstream messaging contracts to further reduce the coupling of our systems to our upstream dependencies?

#### Next Up - Chaos

In the next article of this series we will look at **Chaos** and how we can use thought experiments and existing tools to help improve our system's reliability.
