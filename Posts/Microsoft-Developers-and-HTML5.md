---
tags:
- development
- speculation
- html5
menuorder: 0
id: c1475e88-70c3-4c8f-b122-633cb78e77f0
author: bsstahl
title: Microsoft Developers and HTML5
description: 
ispublished: true
showinlist: false
publicationdate: 2011-07-29T17:25:59
lastmodificationdate: 2011-07-29T17:25:59
slug: Microsoft-Developers-and-HTML5
categories:
- Development

---

Warning: Speculation Alert!

While attending the Pittsburgh GiveCamp, I had something of an epiphany about Microsoft’s HTML5 strategy. Looking back at it now it seems so obvious, but at the time it felt like a revelation, so I want to share that experience with you.  You should be warned however that this is not based on any actual knowledge.  I am not a Microsoft insider and I have no information that any other developer who uses Microsoft technologies doesn’t have access to.  These thoughts are purely speculative, but they make sense to me so I felt the need to share them and I look forward to your comments.


> I believe that Microsoft will make HTML5/CSS3/ECMAScript a 1st-class language within the .NET stack.


Right now, just about everything that can be done in HTML5, can be done in Silverlight and WPF.  Because Microsoft has already spent the time and effort building those technologies into the .NET Framework, there is already the capability in the Microsoft Intermediate Language (IL), which all .NET code compiles down to, to support the actions that might be needed in an HTML5 application.  Certainly, the standard HTML UI elements have an equivalent in the XAML-based world of WPF and Silverlight.  In addition, there is already style support similar to CSS, and we know there is strong programmability support.  So, when you get down to it, all of the framework pieces are in place to compile an HTML5 application into IL.  Once compiled, most likely into an .exe file, this HTML5 application could be executed in exactly the same way as any Windows desktop application.  I believe Microsoft will be announcing this capability as one of its key features of .NET 5 at their Build conference in September to take advantage of the marketing synergy between the .NET 5 and HTML5 brands.

Can you imagine a workflow where you use File –&gt; New Project in Visual Studio to create an HTML5 project, build HTML5 pages along with your script, style and other resources, and then can publish the project as either a standard HTML website, or as a .NET executable file to be run on Windows 8, or even earlier versions of Windows if they have the .NET framework 5.0 installed?  I can imagine it easily, and I like what I see when I do.  This may be why Microsoft is billing the Build conference as for more than just Professional Developers.  That is, web designers and hobbyists will now also have the ability to create Windows desktop applications simply by utilizing the web skills they already possess.

As for the future of WPF and Silverlight, I speculate that, if Microsoft takes the path that I have described, it practically ensures the survival of the XAML technologies.  The HTML5 spec will be constantly evolving and Microsoft will need to continue to add features to the framework to support those new capabilities.  Once in the framework, Silverlight and WPF can add those same or similar features for almost nothing, simply by adding the language support in XAML or C#/VB.Net.  Microsoft will also have two platforms available in Silverlight and WPF to use to test features that are not yet in the HTML5 spec.

It is likely that there will be some consolidation in the future between the two XAML-based technologies, but that was anticipated long before there was any talk of HTML5 as a viable alternative and is not a result of any policy change due to the existence of HTML5. However, HTML5 is looking, for better or worse, like it will become a major player in cross-platform software development. I suspect that many developers who might otherwise have picked-up Silverlight will choose to learn HTML5 instead. In the long-term, if that becomes a significant trend, then eventually WPF and Silverlight will be phased-out.  However, I don’t see that happening anytime soon. In facet, as I mentioned, I feel the synergy with HTML5 found in these technologies makes them stronger in the short and medium term and they will continue to be players in their various spaces for many years.



