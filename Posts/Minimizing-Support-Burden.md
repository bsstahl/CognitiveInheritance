---
author: bsstahl
tags:
- architecture
- coding-practices
- event-driven
- microservices
- reliability
- soa
menuorder: 0
id: 454b2b73-17fa-4bd0-ba87-6d279c7fdc22
title: Minimizing Support Burden - A Comparison of Three Architectures
description: 
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2023-04-24T07:00:00Z
lastmodificationdate: 2023-04-24T07:00:00Z
slug: minimizing-support-burden
categories:
- Development

---

Note: A WIP event storming and other diagrams can be found here: https://lucid.app/lucidchart/3b6a8978-64ab-4458-9dca-88ab3b75767b/edit?beaconFlowId=140CA4DD4F888E74&invitationId=inv_ed1185ed-756e-4d06-84fc-dc6a69f456e6&page=eqs0TI9YjX~X#


There's been some talk lately about well abstracted monoliths and how they may be more effective at times than microservice architectures. While there are almost certainly some use cases where this is true, there are things that a monolith doesn't do as well as other architectures.

* Isolate concerns
* Provide a bus
* [TODO: Pick-up where it left off]

Monoliths, like microservices, can abstract the various concerns to reduce the coupling between them, but monoliths make it much more difficult to determine in which concern a failures occurred, often requiring teams to respond to support issues unnecessarily. Additionally, it is far more risky to add new functionality to a monolith than it is to add it to an event-driven microservice because of the direct nature of the interactions within a monolith.

In this post, we'll compare three architectures and demonstrate why completely separating concerns is important in most non-trivial cases.

## Our Problem Domain

For this example, we'll use an urban bus service provider. When a bus returns to the depot from its daily route, it is cleaned, and then parked in the appropriate staging area for the next day's activities. There are separate staging areas for busses that will be running routes than for those that will be going into the maintenance shop to have work performed. Our application needs to inform the user which staging area to park the bus in when it returns from its route.

The work we need to perform in each of the architectures is to determine if a bus is scheduled to move passengers tomorrow. To do so, we need our *Scheduling* subsystem to check with the various *Maintenance* subsystems to see if the bus is due for maintenance, or if there is a high probability of a failure occurring between now and the end of the bus's run tomorrow.

The development teams supporting this tooling are as follows:

* **Application** - A team of front-end developers working in HTML5, CSS, JavaScript and supporting libraries, as well as back end developers working server-side in technologies such as C#, Java, and Node. This team is responsible for the user interface and the API that supports it.
* **Scheduling** - A team of operations research scientists who are experts in scheduling and optimization, often using Mixed-Integer Programming (MIP) models to perform assignments of busses to routes. Work is done primarily in Python.
* **Preventative Maintenance** - A team of data scientists who work primarily with predictive models, usually based on Machine Learning, to determine when maintenance should be performed on busses. This team is also responsible for making sure that legal requirments for maintenance are met, often using logical models. This team works primarily in Python.


We'll assume for the purpose of demonstration, that each subdomain is supported by a different development team.

## Architecture 1: Monolith

TODO: Change from *all* to the primary subsystem (Scheduling) and describe it in terms of cascading failures from the perspective of Scheduling.

In Architecture 1, all 3 subsystems are contained within a single monolith. The scheduling subsystem receives an API call, calls the 2 dependency subsystems, and stores the results to disk. Any failures within the monolith impact the entire system and present to the caller as a failure within the scheduling process of the system. If a failure occurs in the Preventative Maintenance subsystem, the whole system has failed and all involved need to be prepared to deal with it.

## Architecture 2: Separated API and Business Rules Services

In Architecture 2, the API call is made, validated, and pushed into a reliable messaging system like Azure Service bus or Apache Kafka. Then, the separate Business Rules Services read the message and performs the necessary work. This can be accomplished through either orchestration or choreography, which is the subject of a future article.

## Architecture 3: Push Messages Directly to Reliable Messaging System

In Architecture 3, we can eliminate the need for an API by having the upstream client push the message directly to a reliable messaging system. The Business Rules Services then process the messages from there. In many circumstances, such as when using ProtoBuf or Avro messages in Kafka, these messages can be schema validated using infrastructure, providing much the same level of validation as an API service would, without the need for an additional application team.

As the table demonstrates, in Architectures 1 and 2, failures on message ingress require at least one application team to respond to any failure. This is because these architectures cannot fully isolate application concerns from infrastructure ones. However, in Architecture 3, if there is an Ingress failure, the Infrastructure team is responsible for responding because they are the ones responsible for managing the network and the messaging tooling. Infrastructure implementations also typically offer a higher degree of reliability than applications can.

## Summary

In conclusion, by separating concerns into different services, we can reduce the coupling between different parts of the system and minimize the support requirements for each individual team. Furthermore, by pushing messages directly to a reliable messaging system, we can improve reliability by putting as much burden as possible on the infrastructure pieces, which have the highest reliability guarantees.
