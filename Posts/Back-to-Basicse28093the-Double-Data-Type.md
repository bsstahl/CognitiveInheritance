---
tags:
- double
- int64
- type
- conversion
- csharp
- clr
- data structures
- checked
- unchecked
menuorder: 0
id: c2b6a683-a9cf-4fce-96c1-5401648c056e
author: bsstahl
title: Back to Basics–the Double Data Type
description: 
ispublished: true
showinlist: false
publicationdate: 2019-02-12T02:55:23
lastmodificationdate: 2019-02-12T02:55:23
slug: Back-to-Basicse28093the-Double-Data-Type
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

What is the result of converting a value that is close to, but not at, the maximum value of an Int64 from a double to a long (Int64)?  That is, what would be the result of an expression like:
 `(long)((double)(Int64.MaxValue – 1))`
1. 9223372036854775806 (263-2, the correct value numerically)
2. -9223372036854775808 or another obviously incorrect value
3. OverflowException
4. Any of the above


Based on the framing of the question it is probably clear that the correct answer is "D". It is possible, depending on the hardware details and current state of your system, for any of the 3 possible outcomes.  Why is this and what can we do to be sure that the results of our floating-point operations are what we expect them to be?

Before we go into the ways we can modify the behavior of our operations, let's take a look at the two data types in question, **Int64** and **Double**.

An Int64 value, also known as a long, is a fairly straightforward storage mechanism that uses 63 bits for the value and 1 bit to represent the sign.  Negative numbers are stored in twos-complement form to make mathematical operations simpler.  The result is that the Int64 type can store, with perfect fidelity, any integral value between -9223372036854775808 and 9223372036854775807.

The Double data type on the other hand is far more complex. It requires storage for continuous values, not just integers. As a result, the Double data type uses 52 bits to store the mantissa (value), 11 bits to store the exponent (order of magnitude) and the remaining bit of the 64-bit structure to store the sign. Both the exponent and mantissa are shifted by a few bits based on some fairly safe assumptions.  This gives us a range of values for the exponent of -1023 to 1024 and a little more than 52 bits of fidelity in the mantissa.

It is this difference in fidelity; 63 bits for Int64 and roughly 52 bits for Doubles, that can cause us problems when converting between the two types.  As long as the integer value can be stored in less than 52 bits (value &lt; 4503599627370495) values can be converted back and forth between Int64 and Double without any data loss. However, as soon as the values cannot be represented completely in 52 bits, data loss is likely to occur.

To store such a value in a Double data type, the exponent is adjusted higher and the best available value for the mantissa is found.  When converted back to Int64, this value will be rounded automatically by the framework into the closest integer value. This resulting value may, or may not, be exactly the same as the original value.  To see an example of this, execute the following code in your favorite C# environment:
 `Console.WriteLine((long)9223372036854773765.0);`
If your system is like mine, you’ll get an answer that is not the same as the original value. On my system, I get the result **9223372036854773760**. It is said that this integer does not “round-trip” since it cannot be converted into a Double and then back to an integer.

To make matters worse, the rounding that is required for this conversion can be unsafe under certain conditions. On my machine, if the values get within 512 of Int64.MaxValue, even though they don’t exceed it, attempting the conversion may result in an invalid result, or an **OverflowException**. Even performing the operation without overflow checking using the **unchecked** keyword or compiler switch doesn't improve things since, if done unchecked, any overflow in the operation will result in an incorrect value rather than an exception. I prefer the exception in this kind of situation so I generally keep overflow checking on.

The key takeaway for me is that just checking to make certain that a Double value is less than Int64.MaxValue is not enough to guarantee it will convert without error, and certainly does not guarantee the accuracy of any such conversion. Only integer values below 52 bits can be accurately converted into Int64 values.

It is always best to avoid type conversions if possible, but if you are in a situation where it is necessary to convert from large Double values into Integers, I recommend trying some experiments in your production environment to see what range of values will convert accurately. I also highly recommend including very large integers, approaching or at Int64.MaxValue as test data against any method that accepts Int64 values.  Values that are very large in the negative direction (nearing Int64.MinValue) are also good candidates to be used as test data in these methods.

I’ve attached a number of resources below that I used in my research to produce this article, and to fix the bug I caused doing this kind of conversion.  If you have run into this situation and come up with an interesting way of handling it, or if the results of your conversions are different than mine, please let me know about it on [Twitter](http://www.twitter.com/bsstahl).
 
## Resources
 
    [Double Struct](https://docs.microsoft.com/en-us/dotnet/api/system.double?view=netcore-2.2) in the .NET API Browser
    [Convert.ToInt64 method](https://docs.microsoft.com/en-us/dotnet/api/system.convert.toint64?view=netcore-2.2#System_Convert_ToInt64_System_Double_) in the .NET API Browser
    [double data type](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/double) in the C# Language Reference
    John Skeet on [Binary floating point numbers in .NET](http://csharpindepth.com/Articles/General/FloatingPoint.aspx?printable=true)


John Skeet’s[code to convert doubles to the string representation of their exact decimal value](http://jonskeet.uk/csharp/DoubleConverter.cs)




   

