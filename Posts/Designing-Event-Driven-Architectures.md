---
tags:
- architecture
- coding-practices
menuorder: 0
id: be2ab873-9479-4698-931b-f81d4965d0e0
author: bsstahl
title: Designing Event Driven Architectures
description: A unified process of Event Storming and Event Modeling is a collaborative approach to system design that involves brainstorming and refining Domain Events, tracking causes, grouping logic by Aggregate, and then identifying inputs and outputs, elaborating scenarios, and performing a completeness check to create a comprehensive blueprint of the system.
ispublished: false
buildifnotpublished: true
showinlist: false
publicationdate: 2023-09-01T07:00:00.000+00:00
lastmodificationdate: 2023-09-01T07:00:00.000+00:00
slug: designing-event-driven-architectures
categories:
- Development
        
---
In the realm of software development, the need for effective system design methods is paramount. Two such methods, Event Storming and Event Modeling, have gained traction for their ability to facilitate a comprehensive understanding of complex systems. But what if we could unify these two approaches into a single, streamlined process? Let's explore this idea.

## The Power of Domain Events

Event Storming and Event Modeling both revolve around the concept of 'Domain Events'. A 'Domain Event' is a historical fact, something that happened in the past that is relevant to the business process. These events form the backbone of our system's behavior and are the primary building blocks in both Event Storming and Event Modeling.

## Event Storming: Laying the Groundwork

Event Storming, as defined by Alberto Brandolini, is a rapid, collaborative brainstorming technique used to define the Domain Events, commands, and aggregates in a system. It's primarily used for exploring complex business domains and for knowledge discovery. The process begins with a collection of Domain Events, followed by refining these events, tracking their causes, and finally, aggregation.

In the initial stages, key participants including domain experts, software developers, UX designers, and project managers are invited to brainstorm all the Domain Events that occur within the system. These events are then refined and organized to create a visual map of the system's behavior.

Next, the commands (triggers for the Domain Events) and the views (how the system presents data to the user) are identified. Finally, the logic is grouped by Aggregate to create "sub-systems". This step is about aligning the technical architecture with the business processes, ensuring that the system is designed in a way that makes sense for the organization and its operations.

## Transitioning to Event Modeling

After the Event Storming session, the development team can use the resulting model as a starting point for Event Modeling. This process will involve going into more detail about the system's behavior and data flows.

The team starts by identifying the inputs to the system. This is usually the step in which the introduction of these blue boxes (commands) happens. Next, the team links information accumulated by storing Domain Events back into the UI via views (aka read-models).

Each workflow step is then tied to either a command or a view/read-model. The specifications are constructed one after the other very rapidly while being reviewed by multiple role representatives. Finally, a completeness check is performed to ensure that every field is accounted for and all information has an origin and a destination.

## The Unified process

| Step | Participants | Process | Key Deliverables |
| --- | --- | --- | --- |
| Collect Domain Events | Domain experts, software developers, UX designers, project managers | Event Storming | Collection of Domain Events |
| Refine Domain Events | All participants | Event Storming | Refined and organized Domain Events |
| Track Causes | All participants | Event Storming | Identified commands and views |
| Aggregation | All participants | Event Storming | Grouped logic by Aggregate to create "sub-systems" |
| Identify Inputs | Development team, Product Owner | Event Modeling | Identified inputs to the system (commands) |
| Identify Outputs | Development team, Product Owner | Event Modeling | Linked information accumulated by storing Domain Events back into the UI via views |
| Elaborate Scenarios | Development team, Product Owner | Event Modeling | Specifications for each workflow step |
| Completeness Check | Development team, Product Owner | Event Modeling | Verification that every field is accounted for and all information has an origin and a destination |

## The Intersection of AI and Event Modeling

As we delve deeper into the realm of artificial intelligence and machine learning, the principles of Event Modeling become even more relevant. Large Language Models like GPT and Word2Vec operate in a 60-dimensional vector store, a sphere of capabilities that can be likened to the multi-dimensional space of Domain Events, commands, and views in Event Modeling.

Just as we use Event Modeling to map out the flow of data through a system, we can use similar techniques to map out the flow of information through a machine learning model. For instance, the autocomplete feature in GPT-4 can be seen as a 'view' that presents data to the user based on the 'Domain Events' of the user's input.

## Conclusion

Unifying Event Storming and Event Modeling provides a comprehensive approach to system design, one that combines the strengths of both methods. It allows us to start with a broad overview and then drill down into the specifics, which can be a very effective way to design and understand complex systems. It also ensures that the technical design of the system is closely aligned with the business processes it supports.

So, next time you're faced with the challenge of designing a complex system, why not consider this unified approach? It might just provide the clarity and structure you need to navigate the intricate world of software development. And remember, while it may be challenging, addressing structural deficiencies in your organization to align with your business processes is a worthwhile endeavor that can lead to more efficient and effective systems.
