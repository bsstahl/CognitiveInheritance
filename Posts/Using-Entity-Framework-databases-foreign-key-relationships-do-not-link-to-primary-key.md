---
tags:
- entity framework
- key
- foreign key
- field
- association
- entity
menuorder: 0
id: 02bf7ca7-b667-45fe-86b8-5c2164aa1df7
author: bsstahl
title: Entity Framework Associations on Non-Key Fields
description: Using the Entity Framework with databases that have foreign-key relationships that do not link to the primary key of the child element.
ispublished: true
showinlist: false
publicationdate: 2011-02-03T18:38:00
lastmodificationdate: 2011-03-08T07:26:12
slug: Using-Entity-Framework-databases-foreign-key-relationships-do-not-link-to-primary-key
categories:
- Development

---

Since I have now, for the second time, run into a problem working with Associations on non-key fields in Entity Framework, it is time for me to take a serious look at the issue.

Consider the model below.  There are two entities, a Flight and an Airport.  In this scenario, there are two associations between the entities, Flight.DepartFromAirportId –&gt; Airport.Id and Flight.ArriveAtAirportId –&gt; Airport.Id.  These associations represent the Departure and Arrival airport of the flight.  This model works quite well in Entity Framework 4, making a collection of the arriving and departing flights for each airport available through the navigation properties on the Airport object, and providing a shortcut to the departure and arrival Airport objects for each flight via the navigation properties on the Flight object.

[!\[Flight Airport Ok ERD\](http://www.cognitiveinheritance.com/image.axd?picture=Flight%20Airport%20Ok%20ERD_thumb.png "Flight Airport Ok ERD")](http://www.cognitiveinheritance.com/image.axd?picture=Flight%20Airport%20Ok%20ERD.png)

The problems I’ve seen occur when the database was designed a bit differently, as is sometimes the case with legacy systems.  Let’s take a look at the second model, below.

[!\[Flight Airport Fail ERD\](http://www.cognitiveinheritance.com/image.axd?picture=Flight%20Airport%20Fail%20ERD_thumb.png "Flight Airport Fail ERD")](http://www.cognitiveinheritance.com/image.axd?picture=Flight%20Airport%20Fail%20ERD.png)

Here, we have the same basic model, but instead of the DepartFromAirportId and ArriveAtAirportId foreign-keys on the Flight object, we have DepartFrom and ArriveAt fields which link to the IataCode\* property of the Airport.

The Airport entity still has the same key property, but the Flight doesn’t use it to establish the association. The current version of the Entity Framework is not capable of supporting associations in this type of model.  If you attempt to establish the association through the designer, you cannot select the proper Principal Key and Dependent Property combination to create the link.  If you manually create the association in the XML code, you will get a compiler error.

Fortunately for me, very few of the legacy databases and none of the recently created systems that I work with use this method to create relationships.  However, on the rare occasions that this occurs, it can make life much more complicated. Consider the scenario where I need to get a list of flights that are departing from an airport north of 45 degrees in latitude. In the first model, this is easy using LINQ to Entities.

`var flights = context.Flights.Where(f => f.DepartureAirport.Latitude > 45);`

However, with the second model, since there is no association between the entities, there are no navigation properties that can be followed.  Thus the join has to be done in the LINQ to Entities query, making the syntax much more complex.

`var flights = context.Flights.Where(
   f => context.Airports.Where(a => a.Latitude > 45) 
   .Contains(context.Airports.Where(a => a.IataCode == f.DepartFrom)
   .FirstOrDefault()));`

This query finds the flights where the collection of airports with latitude &gt; 45 degrees contains the one airport that has the IataCode matching the flight’s DepartFrom field.  As you can see, this query is much more difficult to create and maintain then the one which simply uses the Entity Framework provided navigation property.

There is another solution, but I hate to even mention it since I believe it is likely to cause far more problems down the road then it solves now.  That solution, is to manually edit the storage model to fool the Entity Framework into thinking that the properties you wish to use for the association are actually the primary key fields.  Of course, were you to make these changes, then later refresh your model from the database, all of the changes would be lost and you would have to start over.  While this might not seem like such a horrible thing, remember that it might not be you making those changes, or worse, it is you having to deal with an unworkable model left to you by someone else.

\* The Iata Code for an airport is the 3-character code used on your luggage and tickets – PHX, CLT, LAX, ORD, etc.

