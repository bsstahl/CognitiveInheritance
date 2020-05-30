---
tags:
- abstraction
- agile
- coding practices
- microservices
- optimization
- pattern
- principle
- flexibility
- yagni
- event driven
menuorder: 0
id: 578752d7-225b-4510-8de2-2c35ded2eb84
author: bsstahl
title: The Value of Flexibility
description: 
ispublished: true
showinlist: false
publicationdate: 2019-02-14T16:31:05.000+00:00
lastmodificationdate: 2019-02-14T16:31:05.000+00:00
slug: The-Value-of-Flexibility
categories:
- Development

---
Have you ever experienced that feeling you get when you need to extend an existing system and there is an extension point that is exactly what you need to build on?

For example, suppose I get a request to extend a system so that an additional action is taken whenever a new user signs-up.  The system already has an event message that is published whenever a new user signs-up that contains all of the information I need for the new functionality.  All I have to do is subscribe a new microservice to this event message, and have that service take the new action whenever it receives a message. Boom! Done.

Now think about the converse. The many situations we’ve all experienced where there is no extension point. Or maybe there is an extension mechanism in place but it isn’t quite right; perhaps an event that doesn’t fire on exactly the situation you need, or doesn’t contain the data you require for your use case and you have to build an entirely new data support mechanism to get access to the bits you need.


> The cost to “go live” is only a small percentage of the lifetime total cost of ownership. – Andy Kyte for Gartner Research, 30 March 2010


There are some conflicting principles at work here, but for me, these situations expose the critical importance of flexibility and extensibility in our application architectures.  After all, maintenance and extension are the two greatest costs in a typical application’s life-cycle. I don’t want to build things that I don’t yet need because the likelihood is that I will never need them (see [YAGNI](http://www.cognitiveinheritance.com/?tag=/yagni)). However, I don’t want to preclude myself from building things in the future by making decisions that cripple flexibility. I certainly don’t want to have to do a full system redesign ever time I get a new requirement.

For me, this leads to a principle that I like to follow:


> I value **Flexibility** over **Optimization**


As with the principles described in the Agile Manifesto that this is modeled after, this does not eliminate the item on the right in favor of the item on the left, it merely states that the item on the left is valued more highly.  This makes a ton of sense to me in this case because it is much easier to scale an application by adding instances, especially in these heady days of cloud computing, than it is to modify and extend it. I cannot add a feature by adding another instance of a service, but I can certainly overcome a minor or even moderate inefficiency by doing so. Of course, there is a cost to that as well, but typically that cost is far lower, especially in the short term, than the cost of maintenance and extension.

So, how does this manifest (see what I did there?) in practical terms?

For me, it means that I allow seams in my applications that I may not have a functional use for just yet. I may not build anything on those seams, but they exist and are available for use as needed. These include:

- Separating the tiers of my applications for loose-coupling using the Strategy and Repository patterns
- Publishing events in event-driven systems whenever it makes sense, regardless of the number of subscriptions to that event when it is created
- Including all significant data in event messages rather than just keys


There are, of course, dangers here as well. It can be easy to fire events whenever we would generally issue a logging message.  Events should be limited to those in the problem domain (Domain Events), not application events. We can also reach a level of absurdity with the weight of each message. As with all things, a balance needs to be struck. In determining that balance, I value Flexibility over Optimization whenever it is reasonable and possible to do so.

Do you feel differently? If so, let me know on Twitter [@bsstahl](https://twitter.com/bsstahl).