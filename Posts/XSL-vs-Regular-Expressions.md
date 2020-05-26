---
tags:
- xml
- xsl
- regex
menuorder: 0
id: 7033a3af-acf1-49a5-877a-a66d22f175c8
author: bsstahl
title: XSL vs. Regular Expressions
description: 
ispublished: true
showinlist: false
publicationdate: 2006-05-21T04:24:00
lastmodificationdate: 2010-10-22T18:11:35
slug: XSL-vs-Regular-Expressions
categories:
- Development

---

I had an interesting discussion today with a colleague on the use of XSL vs. Regular Expressions. During the course of the conversation, I broke the process of translation down into 3 steps; pattern recognition, data interpretation, and data mapping. XSL excels at all 3 of these tasks, while Regular Expressions can do all 3, but excels primarily at pattern recognition. The result of the conversation was that Regular Expressions should be used in situations where only pattern recognition needs to be done, such as in data validation (i.e. does this string look like an email address) and would be excellent for when only 1 item of data needs to be interpreted (i.e. Grab the email address from this string and do something with it). When multiple data items need to be interpreted and mapped, then XSL is clearly the better choice. Also, XSL is almost always the proper solution when the data is in XML format and is to stay in XML format.

