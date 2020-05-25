---
tags:
- tdd
- unit testing
- properties
- csharp
menuorder: 0
id: ece1a3f3-8f27-40fe-9a89-a13892032e23
author: bsstahl
title: Testing Properties with Inconsistent Accessibility
description: 
ispublished: true
showinlist: false
publicationdate: 2007-06-26T18:18:00
lastmodificationdate: 0001-01-01T08:00:00
slug: Testing-Properties-with-Inconsistent-Accessibility
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

I ran into an interesting problem today while attempting to test a property member which had a **public** getter, but an **internal** setter (a .NET 2.0 construction in C#).

Consider the following class:
![Class Definition](/images/TestClass.png)
This class features an internal constructor, along with a private field (\_id) which is exposed by a property (ID) that is read-only on the public interface, but read-write internally to the assembly. This class looks as shown below in Reflector. Notice that the ID property is recognized as having a **public** getter, but the setter is marked as **internal**.
![Class in Reflector](/images/TestClass%20In%20Reflector.png)  
![Class in Reflector](/images/TestClass%20ID%20Property%20in%20Reflector.png)
Using the Visual Studio 2005 test generator (right-click on the class and select Create Unit Test), I get the following:
[!\[Test Method - As Generated (click for full-size image)\](/images/IDTest_AsGenerated.png)](/images/IDTest_AsGenerated.png)
The problem is, this test will not work (notice the blue squiggly). The error is:


> Property or indexer 'TestClass.ID' cannot be assigned to -- it is read only

  

It appears that the code-generator only looks at the primary property scope delaration, that it is **public**, and ignores the **internal** qualifier on the setter. As a result, the code-generated accessor for the object does not contain an accessor for the ID property, and the generated test will not compile since the property is, in fact, settable only internal to the assembly.

The work-around here is actually quite simple, that is to do within the test what the code-generated accessor object normally does for us:
[!\[Test Method - Workaround (click for full-size image)\](/images/IDTest_Workaround.png)](/images/IDTest_Workaround.png)
I figure that Microsoft knows about this problem by now, but I couldn't find anything about it on the net. I may not have been searching using the appropriate terminology. I'll send Scott Guthrie a note just in case. If you are aware of another way around this problem, or if you know of a way to get the code-generator to act properly under these conditions, I would be very interested to hear about it.

