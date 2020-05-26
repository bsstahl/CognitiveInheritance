---
tags:
- pdc
- azure
- cloud
- csharp
- dynamic
menuorder: 0
id: 31ea041b-f62a-4f0a-a63e-453c79435c03
author: bsstahl
title: PDC 2008 Day 1
description: 
ispublished: true
showinlist: false
publicationdate: 2008-10-29T15:29:00
lastmodificationdate: 2011-03-08T07:26:23
slug: PDC-2008-Day-1
categories:
- Event

---

### Windows Azure

As you've probably already heard, the big announcement coming out of PDC 2008 Day 1 was "Windows Azure", Microsoft's Cloud Computing Operating System. This is a very interesting story since it has implications, in theory at least, for developers working in any size organization, who need to provide public services that could potentially scale globally or massively. I won't spend time on the specifics right now since there are many who are more knowledgeable than me who have already written about it.  I do however, have a few open questions on the topic, which I hope to have answered either in sessions today, or in the hands-on-labs.  These include the pricing model (i.e. whether it will really be affordable for the "garage developer"), as well as what actually constitutes an Azure "web role". If, as I suspect, a web role can be a SOAP service or an ASP.NET web page, then the model makes a lot of sense to me and I will definitely be spending some time becoming familiar with the features and capabilities of this tool.  I have sketched-out a simple application model that I hope to implement, either in the hands-on-labs or in the online community preview, sometime today.  Since I have not yet been granted access to the public CTP, I suspect this will have to occur in the hands-on-labs.

### The Future of .NET Development

The other major topic of the sessions I attended during day 1 was the future of development on the .NET platform.  Specifics here included details of Visual Studio 2010 as well as a fantastic language futures talk given by Anders Hejilsberg, the father of C#.  According to Anders, "The major theme of C# 4.0 is Dynamic Programming" which will allow C# applications to interact with dynamic languages such as JavaScript and Ruby, as well as providing dynamic typing features within C# itself.  While, in most cases, I wouldn't (and I think Anders wouldn't) recommend using dynamic typing mechanisms, there are times where it is the most appropriate way (sometimes the only way) of performing the task at hand.

![Anders Hejilsberg, the Father of C# at PDC 2008](http://farm4.static.flickr.com/3185/2980079795_9966620683.jpg)

Another feature of future versions of C# include the concept of the compiler as a service. That is, the C# compiler, sometime down the road, is expected to be made available within the application model, useable by applications. We have had other methods of dynamically generating code in the past, but no model nearly as compelling as utilizing the same compiler Visual Studio uses, as a component of the .NET framework.

### Sessions Available Online

We are being told that videos of every session will be available online via [http://www.microsoft.com/pdc](http://www.microsoft.com/pdc) 24-hours after the session. From day 1, I definitely recommend checking out the keynote as an interesting, although far from complete, overview of Azure.  I also recommend Anders' talk on C#.  There was one session that looked interesting that I couldn't get into called "C# IDE Tips and Tricks" that seemed interesting which I will be checking-out online within the next week or so.

Day 2 begins...now.

