---
tags:
- encapsulation
- generics
- list
menuorder: 0
id: 2eb911d4-b484-48f6-9986-5534a1f5581f
author: bsstahl
title: Encapsulation and Generic Lists
description: 
ispublished: true
showinlist: false
publicationdate: 2007-09-16T09:10:00
lastmodificationdate: 2010-10-22T18:11:17
slug: Encapsulation-and-Generic-Lists
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

It has often been said that each new language feature gives programmers more rope with which to hang themselves. Unfortunately, what it really seems like is that each feature gives other programmers more rope with which to hang me, or you, or whomever the next poor schmuck is who has to deal with their code. Back in the relatively early days of .NET 2.0, I wrote about [some concerns I had with Generics](http://74.125.95.132/post.aspx?id=a23af054-42e2-47a9-874e-d7b4d8eadb5b). It has turned out that Generics are everything I could have hoped for in a language feature, and everything I feared.

Generics are an outstanding way of dealing with a number of issues in a very elegant, but also type-safe way. Among many things, this includes collections. I see no reason why there should be any new collections created that are not based on Generics and it is my understanding that System.Collections.CollectionBase (the non-Generic base collection class) is to be deprecated sometime in the near future. However, as I feared over a year ago, there are many that miss the point somewhat and expose List&lt;t&gt; on their interfaces. The Generic List object is a very powerful and easy to use collection, but it is not extensible. If you write code that exposes List&lt;t&gt;, you are effectively passing a strongly-typed array-list. Doing this breaks encapsulation because any code we write against that list, has to be repeated everywhere we want to perform that operation.

For example, suppose we have a calendar object that exposes a list of events that we want to reserve. We often see this code:

List&lt;CalendarEvent&gt; calendarEvents = Calendar.Events;  
 for each (CalendarEvent evt in calendarEvents)  
     evt.Reserve();

rather than the far preferable:

CalendarEventsCollection calendarEvents = Calendar.Events;  
 calendarEvents.Reserve();

where the CalendarEventsCollection object contains:

public void Reserve()  
 {  
     for each (CalendarEvent evt in this)  
         evt.Reserve();   
 }

or even better:

Calendar.ReserveEvents();

where the Calendar object contains:

private CalendarEventsCollection \_calendarEvents;  
 public CalendarEventsCollection Events  
 { return \_calendarEvents; }  
  
 public void ReserveEvents()  
 {  
     this.Events.Reserve();  
 }

The latter being preferable because all of the functionality we want to expose is completely encapsulated in the appropriate object and doesn't have to be repeated wherever it is needed. Of course, we can't do this if we are lobbing around List&lt;t&gt; instead of collection objects that derive from System.Collections.ObjectModel.Collection.

While the improper use of List&lt;t&gt; may not be exactly the "House of Sticks" that I feared in early 2006, it is an item where proper use is not necessarily obvious and which has been misunderstood by many very good programmers.  Please, encourage all developers to practice proper encapsulation by deriving collection classes from one of the Generic collection implementations.

