---
tags:
- apache
- cordova
- development
- device
- drdre
- framework
- html5
- ionic
- javascript
- open source
- phone
- standardization
- visual studio
- win8
- wp8
- xaml
menuorder: 0
id: ceb59f2f-55d7-447b-8470-a19d93fb29e7
author: bsstahl
title: Are you Ready for the Next Episode?
description: 
ispublished: true
showinlist: false
publicationdate: 2015-06-29T19:45:05
lastmodificationdate: 2015-06-29T19:45:05
slug: Are-you-Ready-for-the-Next-Episode
categoryids:
- categoryid: da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

In the last episode of “[Refactoring my App Development Mojo](http://www.cognitiveinheritance.com/post.aspx?id=1ad203b0-f604-43c0-8293-aad482376f98)”, I explained how I had discovered my passion for building Windows Store applications by using a hybrid solution of HTML5 with very minimal JavaScript, bound to a view-model written in C# running as a Windows Runtime Component, communicating with services written in C# using WCF.  The goal was to do as much of the coding as possible in the technologies I was very comfortable with, C# and HTML, and minimize the use of those technologies which I had never gotten comfortable with, namely JavaScript and XAML.

While this was an interesting and somewhat novel approach, it turned out to have a few fairly significant drawbacks:



1. Using this hybrid approach meant there were two runtimes that had to be initialized and operating during execution, a costly drain on system resources, especially for mobile devices.
2. Applications built using this methodology would run well on Windows 8 and 8.1 machines, as well as Windows Phone devices, but not  on the web, or on Android or iDevices.
3. The more complex the applications became, the more I hand to rely on JavaScript anyway, even despite putting as much logic as possible into the C# layers.


On top of these drawbacks, I now feel like it is time for me to get over my fear of moving to JavaScript. Yes, it is weakly typed (at least for now). Yes, its implementation of many object-oriented concepts leave a lot to be desired (at least for now), yes, it can sometimes make you question your own logical thinking, or even your sanity, with how it handles certain edge-cases. All that being said however, JavaScript, in some form, is the clear winner when it comes to web applications. There is no question that, if you are building standard front-ends for you applications, you need JavaScript.

So, it seems that it is time for me to move to a more standard front-end development stack.  I need one that is cross-platform, ideally providing a good deployment story for web, PC, tablet & phone, and supporting all major platforms including Android, iDevices & Windows phones and tablets.  It also needs to be standards-based, and work using popular frameworks so that my apps can be kept up-to-date with the latest technology.

I believe I have found this front-end platform in [Apache Cordova](https://cordova.apache.org/). Cordova takes HTML5/JavaScript/CSS3 apps that can already work on the web, and builds them into hybrid apps that can run on virtually any platform including iPhones and iPads, Android phones and tablets, and Windows PCs, phones and tablets. Cordova has built-in support in Visual Studio 2015, which I have been playing with for a little while and seems to have real promise.  There is also the popular [Ionic Framework](http://ionicframework.com/) for building Cordova apps which I plan to learn more about over the next few weeks.

I’ll keep you informed of my progress and let you know if this does indeed turn out to be the best way for me to build apps. Stay tuned.

