---
author: bsstahl
tags:
- ai
- embedding
categories:
- Tools
menuorder: 0
id: e47eddf9-fcda-4382-a7c8-e498026fbfee
title: The Depth of GPT Embeddings
description: This article explores the number of possible representations in a GPT vector. The author calculates that with 7 decimal digits of precision, we can represent an astronomically large number of distinct values in a vector, suggesting that these models could hold insights yet to be discovered by humans.
teaser: This article describes the depth of GPT embeddings, calculating the number of possible representations in a GPT vector. This analysis suggests that these models likely hold untapped insights, waiting to be discovered.
ispublished: true
showinlist: false
buildifnotpublished: true
publicationdate: 2023-10-03T07:00:00Z
lastmodificationdate: 2023-10-03T08:00:00Z
slug: depth-of-gpt-embeddings
---
I've been trying to get a handle on the number of representations possible in a GPT vector and thought others might find this interesting as well. For the purposes of this discussion, a GPT vector is a 1536 dimensional structure that is unit-length, encoded using the **text-embedding-ada-002** embedding model.

We know that the number of theoretical representations is infinite, being that there are an infinite number of possible values between 0 and 1, and thus an infinite number of values between -1 and +1. However, we are not working with truly infinite values since we need to be able to represent them in a computer. This means that we are limited to a finite number of decimal places. Thus, we may be able to get an approximation for the number of possible values by looking at the number of decimal places we can represent.

### Calculating the number of possible states

I started by looking for a lower-bound for the value, and incresing fidelity from there. We know that these embeddings, because they are unit-length, can take values from -1 to +1 in each dimension. If we assume temporarily that only integer values are used, we can say there are only 3 possible states for each of the 1536 dimensions of the vector (-1, 0 +1). A base (B) of 3, with a digit count (D) of 1536, which can by supplied to the general equation for the number of possible values that can be represented:

**V = B<sup>D</sup>** or **V = 3<sup>1536</sup>**

The result of this calculation is equivalent to 2<sup>2435</sup> or 10<sup>733</sup> or, if you prefer, a number of this form:

```
10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
```

Already an insanely large number. For comparison, the number of atoms in the universe is roughly 10<sup>80</sup>.

We now know that we have at least 10<sup>733</sup> possible states for each vector. But that is just using integer values. What happens if we start increasing the fidelity of our value. The next step is to assume that we can use values with a single decimal place. That is, the numbers in each dimension can take values such as **0.1** and **-0.5**. This increases the base in the above equation by a factor of 10, from 3 to 30. Our new values to plug in to the equation are:

**V = 30<sup>1536</sup>**

Which is equivalent to **2<sup>7537</sup>** or **10<sup>2269</sup>**.

Another way of thinking about these values is that they require a data structure not of 32 or 64 bits to represent, but of 2269 bits. That is, we would need a data structure that is 2269 bits long to represent all of the possible values of a vector that uses just one decimal place.

We can continue this process for a few more decimal places, each time increasing the base by a factor of 10. The results can be found in the table below.

<table border=1>
<tr><th>B</th><th>Example</th><th>Base-2</th><th>Base-10</th></tr>
<tr><td>3</td><td>1</td><td>2435</td><td>733</td></tr>
<tr><td>30</td><td>0.1</td><td>7537</td><td>2269</td></tr>
<tr><td>300</td><td>0.01</td><td>12639</td><td>3805</td></tr>
<tr><td>3000</td><td>0.001</td><td>17742</td><td>5341</td></tr>
<tr><td>30000</td><td>0.0001</td><td>22844</td><td>6877</td></tr>
<tr><td>300000</td><td>0.00001</td><td>27947</td><td>8413</td></tr>
<tr><td>3000000</td><td>0.000001</td><td>33049</td><td>9949</td></tr>
<tr><td>30000000</td><td>0.0000001</td><td>38152</td><td>11485</td></tr>
<tr><td>300000000</td><td>0.00000001</td><td>43254</td><td>13021</td></tr>
<tr><td>3000000000</td><td>0.000000001</td><td>48357</td><td>14557</td></tr>
<tr><td>30000000000</td><td>1E-10</td><td>53459</td><td>16093</td></tr>
<tr><td>3E+11</td><td>1E-11</td><td>58562</td><td>17629</td></tr>
</table>

This means that if we assume 7 decimal digits of precision in our data structures, we can represent **10<sup>11485</sup>** distinct values in our vector.

This number is so large that all the computers in the world, churning out millions of values per second for the entire history (start to finish) of the universe, would not even come close to being able to generate all of the possible values of a single vector.

### What does all this mean?

Since we currently have no way of knowing how dense the representation of data inside the GPT models is, we can only guess at how many of these possible values actually represent ideas. However, this analysis gives us a reasonable proxy for how many the model can hold. If there is even a small fraction of this information encoded in these models, then it is nearly guaranteed that these models hold in them insights that have never before been identified by humans. We just need to figure out how to access these revelations.

That is a discussion for another day.
