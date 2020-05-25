---
tags:
- SOA
- agile
- interface
- services
- sla
- wcf
menuorder: 0
id: 9b51fb05-53a6-44e0-bddb-fddfa1b542dc
author: bsstahl
title: Two Features you Need in Your Service SLAs
description: 
ispublished: true
showinlist: false
publicationdate: 2014-09-22T18:04:56
lastmodificationdate: 2014-09-22T18:04:56
slug: Two-Features-you-Need-in-Your-Service-SLAs
categoryids:
- categoryid: da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

To allow ourselves to create the best possible services for our clients, it is important to make those services as flexible and maintainable as possible.  Building services in an agile way helps us to create better services, however it makes it more likely that our service interface will, at some point, have to change.  Changing a service interface after publication is, and should be, a well gated, well thought-out process. By changing the interface, you are changing the contract your service has with all of your clients, and you are probably requiring every one of the service consumers to change.  This should not be done lightly. However, there are a few things that can be done to minimize the impacts of these changes. Several of these things require agreements with the clients up front.  As a result, these items should be included in the Service Level Agreement (SLA) between the service providers and the consumers.

***Caveat**: I am a solution architect, not an expert in creating service level agreements.  Typically, my only involvement with SLAs is to object when I can’t get what I need in one from a service provider. My intent here is to call-out a few things that all service providers should include in their SLAs to maintain the flexibility of their APIs. There are many other things that should be included in any good SLA that I will not be discussing here.*

The two items that I believe should be included in all service SLAs are the requirements that the clients support both Lax Versioning and Forward Compatible Contracts.  Each of these items is discussed in some detail below.

### Lax Versioning

Lax Versioning allows us to add new, optional members to the data contract of the service without that change being considered a breaking change. Some modern service frameworks provide this behavior by default and many of the changes we might make to a service fall into this category.  By reducing the number of changes that are considered breaking, we can lessen the burden on our implementation teams, reducing coordination requirements with service consumers, and shortening time to market of these changes.

One of the major impacts that Lax Versioning has is that it requires us to either avoid schema validation altogether, or to use specially designed, versionable schemas to do our validation.  I recommend avoiding schema validation wherever reasonable and possible.

### Forward Compatible Contracts

Forward Compatible Contracts, also known as the Round-Tripping of Unknown Data, requires that the service round-trip any additional data it gets, but doesn’t understand, back to the client and that clients round-trip any additional data they get, but don’t understand, back to the server.  This behavior reduces the coupling between client and server for changes that are covered by Lax Versioning, but need to retain the additional data throughout the call life-cycle.

For example, suppose we were version a contract such that we added an additional address type to an employee entity  (V1 only has home address, V2 has home and work addresses).  If we change the service to return the V2 employee prior to changing the client, the client will accept the additional (optional) address type because we have already required Lax Versioning, but it will not know what to do with the information.  If a V1 client without round-tripping support sends that employee back to the server, the additional address type will not be included.  If however, the V1 client supports this round-tripping behavior, it will still be unable to use the data in the additional address field, but will return it to the server if the entity is sent back in a subsequent call.  These behaviors with a V1 client and a V2 service are shown in the diagram below.

[!\[image\](http://www.cognitiveinheritance.com/image.axd?picture=image_thumb_4.png "image")](http://www.cognitiveinheritance.com/image.axd?picture=image_4.png)

If the same practice is used on the server side, then we can decouple the client and server from many implementation changes.  Clients would be free to implement the new versions of contracts as soon as they are ready, without having to wait for the service to roll-out.  Likewise, many changes at the service side could be made knowing that data sent down to the clients will not be lost when it is returned to the server.

## Summary

Making changes to the contract of existing services is a process that has risk, and requires quite a bit of coordination with clients. Some of the risks and difficulties involved in the process can be mitigated by including just 2 requirements in the Service Level Agreements of our services.  By requiring clients to implement Lax Versioning and making our contracts Forward Compatible, we can reduce the impact of some changes, and decouple others such that we significantly reduce the risk involved in making these changes, and improve our time-to-market for these deployments.

