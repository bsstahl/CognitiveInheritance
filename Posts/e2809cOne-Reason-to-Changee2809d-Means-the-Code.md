---
tags:
- class
- coding-practices
- development
- solid
- oop
menuorder: 0
id: b3dd8698-1f6b-412f-ab52-a48422b79926
author: bsstahl
title: “One Reason to Change” Means the Code
description: 
ispublished: true
showinlist: false
publicationdate: 2015-07-06T14:43:01
lastmodificationdate: 2015-07-06T14:43:01
slug: e2809cOne-Reason-to-Changee2809d-Means-the-Code
categories:
- Development

---

There was some confusion last week at the SoCalCodeCamp about what the phrase “One Reason to Change” actually means.  As you probably know, the Single Responsibility Principle states that every class should have one and only one responsibility within the system. A common check for adherence to this principal is that the object has only one reason to change. However, it is important to realize that this is referring to the code (the class), not the state of the object (the instance).  The state of the object may have many reasons to change, however, we as developers should have only 1 reason to change the code for our objects.  For example, if the object is in the business-rules layer, we should only have to change the code if the business rules change.  Likewise, if the object is in the data tier, it should only need code changes if the structure of the data changes.

