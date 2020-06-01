---
tags:
- datetime
- type
- time zone
menuorder: 0
id: c541f92a-a77e-4556-a13d-0b8cb70a9518
author: bsstahl
title: Use System.DateTimeOffset To Better Handle Time Zones
description: 
ispublished: true
showinlist: false
publicationdate: 2008-12-25T10:55:00.000+00:00
lastmodificationdate: 2009-03-03T19:50:22.000+00:00
slug: Use-SystemDateTimeOffset-To-Better-Handle-Time-Zones
categories:
- Development

---
In his post, [The Death of System.DateTime?](https://web.archive.org/web/20151024033950/https://weblogs.asp.net/okloeten/6795009) Omer van Kloeten evaluates the use of the System.DateTimeOffset object in place of System.DateTime to improve handling of Time Zone sensitive times.

> When representing a date/time, especially in an internationally-faced system, you have to include a time-zone. DateTime did a very poor job handling time-zones, like being insensitive to changes. DateTimeOffset is the exact same thing as DateTime, only it takes heed of time-zones. For instance, comparing two DateTimeOffsets with the same UTC time in different time-zones will result in equality.
> 
> Moreover, DateTime also had only three modes: Local, UTC and Unspecified, whereas DateTimeOffset has an Offset property, allowing you to create dates in any time-zone you like.

I have not yet experimented with the System.DateTimeOffset type but what Omer says makes a lot of sense to me.  Has anyone else played with this object?