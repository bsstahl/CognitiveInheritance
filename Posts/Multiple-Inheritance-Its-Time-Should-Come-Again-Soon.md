---
tags:
- clr
- .net framework
- inheritance
- interface
menuorder: 0
id: bbcd1ce3-22d3-47b2-90b0-02fef43a1984
author: bsstahl
title: Multiple Inheritance - Its Time Should Come Again Soon
description: 
ispublished: true
showinlist: false
publicationdate: 2008-06-16T15:17:00
lastmodificationdate: 2010-10-22T18:11:02
slug: Multiple-Inheritance-Its-Time-Should-Come-Again-Soon
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

Over the last few years I've heard a number of public statements from developers about the lack of need for multiple implementation inheritance in .NET and other modern development platforms. Their logic often seems to imply that if you need multiple implementation inheritance, you are not designing your applications properly.  While admittedly, there are usually work-arounds (such as interface inheritance) that allow us to simulate this feature, they usually require that portions of our code are duplicated, violating the Agile requirement "Don't Repeat Yourself".

One commonly seen example of where multiple implementation inheritance would be very valuable is in multi-tiered, domain specific applications, especially in the data-tier where we may wish to have more-than-one implementation to support multiple data-stores.  Think about the typical data-tier scenario. In this scenario we have a set of domain objects, based on an inherited set of entities with common properties and methods that represent a physical object in the problem domain. These objects also have a commonality in that they are implementations of an object-type common to that data store and may have properties and methods relating specifically to the storage of data.  So, an object whose responsibility it is to persist an Employee entity to a SQL Server data store, could inherit from both our domain Employee entity, and our SQL Data Storage object.  If we also had an implementation that stored data in XML format, we might have an object that inherits both from the same Employee entity as well as from the XMLNode object. If multiple implementation inheritance were supported in our framework, we could avoid the common work-around of repeating our entity implementation by using an interface to simulate that inheritance, or by simply repeating our data persistence logic in each object.

I certainly understand the need to ship a product.  Since I am also well aware of the added complexity that multiple implementation inheritance creates in compilers and frameworks, it is easy for me to imagine why this feature did not make it into either of the first two major revs of Microsoft's Common Language Runtime.  It is my opinion however that, with the third major release of the CLR forthcoming (Rev 3s being where Microsoft traditionally "nails it") they should strongly consider adding support for multiple implementation inheritance.

