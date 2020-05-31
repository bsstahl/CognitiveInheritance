---
tags:
- yagni
- standardization
- coding practices
- code analysis
- tdd
- unit testing
menuorder: 0
id: 9b50d169-d967-4ee1-ba25-e97713bed19b
author: bsstahl
title: Conflict of Interest -- YAGNI vs. Standardization
description: 
ispublished: true
showinlist: false
publicationdate: 2014-07-28T13:42:10.000+00:00
lastmodificationdate: 2014-07-28T13:42:10.000+00:00
slug: Conflict-of-Interest-YAGNI-vs-Standardization
categories:
- Development

---
While working on the OSS project mentioned in my [previous post](http://www.cognitiveinheritance.com/post/New-OSS-Project.aspx), I have run across a dilemma where two of the principals I try to work by are in conflict. The two principals in question are:

1. **YAGNI** - *You aint gonna need it*, which prescribes not coding anything unless the need already exists. This principal is a core of Test Driven Development of which I am a practitioner and a strong proponent.
2. **Standardization** - Where components, especially those built for use by other developers, are implemented in a common way in order to shorten the learning curve of future developers who will use the component and to reduce implementation bugs.


I have run across this type of decision many times before and have noted the following:

- YAGNI is usually correct, if you don't need it now, you are unlikely to need it in the future.
- Standard implementations which are built incompletely tend to be implemented badly later because there tends to be more time pressure further along into projects, and because it is often implemented by someone other than the original programmer who may not be as familiar with the pattern.
- The fact that there is less time pressure early in projects is another great reason to respect YAGNI because if we are always writing unnecessary code early in projects, a project can quickly become late.
- Implementing code that is not currently required by the use-cases being built requires the addition of unit tests that are specific to the underlying functionality rather than user requested features. While often valuable, the very fact that we are writing such tests is a code smell.
- Since I use FxCop Code Analysis built-in to Visual Studio, not supplying all features of a standard implementation may require overriding one or more analysis rules.


Taking all of this into account, the simplest solution (which is usually the best) is to override the FxCop rules in the code, and continue without implementing the unneeded, albeit standard features.

Do you disagree with my decision? Tell me why on Twitter {TwitterLink}.