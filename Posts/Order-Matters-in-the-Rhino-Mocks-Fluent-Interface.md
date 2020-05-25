---
tags:
- abstraction
- tdd
- testing
- mocks
menuorder: 0
id: 127542b6-45e7-4ca9-a338-5ebce5385184
author: bsstahl
title: Order Matters in the Rhino Mocks Fluent Interface
description: 
ispublished: true
showinlist: false
publicationdate: 2012-01-16T15:35:00
lastmodificationdate: 2012-01-26T20:15:51
slug: Order-Matters-in-the-Rhino-Mocks-Fluent-Interface
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

I noticed something interesting with Rhino Mocks today while testing some demo code:
 `Rhino.Mocks.Expect.Call(myDependency.MyMethod(param1)).Return(result).Repeat.Times(5);`
behaves as I anticipated; it expects the call to **MyMethod** to be repeated 5 times and returns the value of **result** all 5 times. Meanwhile:
 `Rhino.Mocks.Expect.Call(myDependency.MyMethod(param1)).Repeat.Times(5).Return(result);`
also has the expectation of 5 executions, but it returns the value of **result** only once. The other 4 executions return **0**.

When I think about it now, it makes sense, but it wasn't the behavior I originally expected.

