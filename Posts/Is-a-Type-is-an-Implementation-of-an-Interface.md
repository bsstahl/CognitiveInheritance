---
tags:
- assembly
- api
- class
- code sample
- coding practices
- community
- csharp
- development
- extension method
- framework
- generics
- interface
- presentation
- professional development
- reflection
- user group
menuorder: 0
id: 464d1675-ae11-4ad2-b088-4aa806582210
author: bsstahl
title: Is a Type an Implementation of an Interface?
description: 
ispublished: true
showinlist: false
publicationdate: 2016-11-17T21:34:16
lastmodificationdate: 2016-11-17T21:45:48
slug: Is-a-Type-is-an-Implementation-of-an-Interface
categoryids:
- categoryid: da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

One of the techniques I recommend highly in my [Simplify Your API](http://www.cognitiveinheritance.com/post/Simplify-Your-API.aspx) talk is the use of extension methods to hide the complexity of lower-level API functionality.  A good example of a place to use this methodology came-up last night in a great Reflection talk by Jeremy Clark ([Twitter](https://twitter.com/jeremybytes), [Blog](https://jeremybytes.blogspot.com/)) at the [NorthWest Valley .NET User Group](http://www.nwvdnug.org).

[!\[Jeremy\](http://www.cognitiveinheritance.com/image.axd?picture=Jeremy_thumb_2.jpg "Jeremy Clark at the NWVDNUG")](http://www.cognitiveinheritance.com/image.axd?picture=Jeremy_2.jpg)

Jeremy was demonstrating a method that would spin-through an assembly and load all classes within that assembly that implemented a particular interface.  The syntax to do the checks on each type were just a bit more obtuse than Jeremy would have liked them to be.  As we left that talk, I only half-jokingly told Jeremy that I was going to write him an extension method to make that activity simpler.  Being a man of my word, I present the code below to do just that.
 
