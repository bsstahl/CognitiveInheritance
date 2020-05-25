---
tags:
- api
- coding practices
- framework
- interface
- standardization
- using
menuorder: 0
id: e3217f4e-426d-4a6e-99f0-9f00b92c7f00
author: bsstahl
title: Not Following API Guidelines Has Impact
description: 
ispublished: true
showinlist: false
publicationdate: 2016-01-25T17:07:21
lastmodificationdate: 2016-01-25T17:07:21
slug: Not-Following-API-Guidelines-Has-Impact
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

Good API design requires the developer to return responses that provide useful and understandable information to the consumers of the API.  To effectively communicate with the consumers, these responses must utilize standards that are known to the developers who will be using them.  For .NET APIs, these standards include:

- Implementing *IDisposable* on all objects that need disposal.
- Throwing a *NotImplementedException* if a method is on the interface and is expected to be available in the future, but is not yet available for any reason.
- Throwing an *ArgumentException* or *ArgumentNullException* as appropriate to indicate that bad input has been supplied to a method.
- Throwing an *InvalidOperationException* if the use of a method is inappropriate or otherwise unavailable in the current context.


**One thing that should absolutely not be done is returning a NULL from a method call unless the NULL is a valid result of the method, based on the provided input.**

I have spent the last few weeks working with a new vendor API.  In general, the implementation of their API has been good, but it is clear that .NET is not their primary framework.  This API does 2 things that have made it more difficult than necessary for me to work with the product:

1. Disposable objects don’t implement *IDisposable*. As a result, I cannot simply wrap these objects in a *Using* statement to handle disposal when they go out of scope.
2. Several mathematical operators were overloaded, but some of them were implemented simply by returning a *NULL*. As a result:
    1. I had to decompile their API assembly to determine if I was doing something wrong.
    2. I am still unable to tell if this is a permanent thing or if the feature will be implemented in a future release.


Please follow all API guidelines for the language or framework you are targeting whenever it is reasonable and possible to do so.

