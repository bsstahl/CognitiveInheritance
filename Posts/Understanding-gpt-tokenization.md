---
author: bsstahl
tags:
- development
- ai
categories:
- Tools
menuorder: 0
id: 802ad127-19a0-4a19-9bc7-a753e64d3124
title: Understanding GPT Tokenization
description: 
teaser: 
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2024-03-01T07:00:00Z
lastmodificationdate: 2024-03-01T08:00:00Z
slug: understanding-gpt-tokenization

---
## Introduction

[TODO: Why are we here?]

## Tokenization in natural language processing (NLP)

Tokenization is the process of converting text input into a numeric form that machine learning models can interpret. During this process, text strings are broken into segments, often corresponding to words, phrases, or other meaningful elements, and each segment is then mapped to one or more unique integer values called tokens. This numerical representation allows algorithms to perform operations on textual data since the models require quantitative inputs.

### Why Tokenization?

NLP models utilize tokenization over direct UTF-8 byte representation because tokens offer meaningful linguistic units that align with the way language is structured and understood. Tokens abstract text into discrete elements that capture semantics, enable better generalization, and facilitate sequence processing. This approach simplifies the complexity inherent in multi-byte characters and enhances model efficiency by reducing the input space. Consequently, tokenization leads to more compact, contextually aware, and semantically rich representations that are essential for the sophisticated pattern recognition tasks required in NLP.

By translating text into a sequence of numbers, tokenization enables the algorithmic manipulation necessary for tasks like pattern recognition, language modeling, and predictive text analysis within the realm of NLP.

### The *cl100k* Tokenization Model

The `cl100k` tokenization model is the encoding scheme employed by OpenAI's GPT (Generative Pre-trained Transformer) models. This encoding is built to parse input text into 100,256 (100k) different tokens, efficiently representing a vast range of linguistic elements from individual characters to full words and phrases in numerous languages and alphabets. This approach allows GPT models to grasp the nuances of language, handle a variety of linguistic tasks, and generate coherent, contextually relevant text based on the input they receive. The cl100k tokenizer is an integral part of how GPT models manage to achieve their impressive performance in generating human-like text.

## The *cl100k* Tokenizer Sample Code

I found it difficult to understand the tokenization process from looking at the code for some of the standard implementations. There is a simple reason for this -- those implementations are optimized for speed and efficiency, not for clarity and understanding. To solve this problem, and help my understanding of this process, I created a new implementation using an object-oriented approach. This implementation prioritizes clarity over performance, making the concepts of encoding and decoding with `cl100k` far more accessible for educational purposes. This approach allows learners to investigate the nuances of tokenization without getting lost in the weeds of complex array operations. The code is written in *C#* and is available on [GitHub](https://github.com/bsstahl/AIDemos/tree/master/Tokenizer).

### *cl100k* Tokenization Replacements

The key to the tokenization process using *cl100k* is the replacements data, found in the [cl100k_base.tiktoken file](https://github.com/bsstahl/AIDemos/blob/master/Tokenizer/Tokenizer/data/cl100k_base.tiktoken) in the code sample. This file contains a list of Base-64 encoded strings, and the token that each string represents. A decoded version of this file can be found in {PageLink:cl100k-token-replacements|this table}. 

[TODO: Walk throught the sample code, explaining how the Encode and Decode methods work]

## Intriguing Token Findings

* Longest Value Tokens
  * Discussion on the longest value (128 spaces) and its significance
  * Other tokens beyond 42 characters long
* Tokens Beyond Programming
  * Presentation of the longest readable term .translatesAutoresizingMaskIntoConstraints
  * Exploration of the longest term not programming related: abcdefghijklmnopqrstuvwxyz
  * Analysis of the longest word not specifically programming related:  responsibilities
* Social Media's Influence
  * Examination of the term unconstitutional and its reflection of social media content
* Notable Tokens
  * Insights into tokens like -m, mary, and значения
  * The curious case of redacted text representation with █████

### The Tokenization of US Presidents Last Names

The tokenization of the names of US presidents within the *cl100k* model presents a fascinating case study in how natural language processing deals with proper nouns, particularly those with high cultural and historical significance. The way these names are broken down into tokens can reveal patterns in the dataset's composition and the model's efficiency at encoding information. For instance, some presidential last names require multiple tokens to represent, while others can be captured in a single token, often depending on their frequency in the training data or their commonality in the English language. The variation in tokenization—from 'Ford' having multiple representations due to its regular appearance as a common noun or brand name, to more unique surnames—highlights the intricate balance between context, frequency, and the distinctiveness of proper nouns in the realm of machine learning. Understanding this can provide insights into the model's linguistic comprehension and its potential biases or strengths in recognizing and processing culturally relevant names.

Of the 40 distinct last names of US Presidents:

* 7 require more than 1 token to represent in any form
* 22 have only 1 way to represent it in a single token, usually with a leading space andinitial cap
* Ford has 4 ways, which makes sense since there are so many other reasons to write thatname
* All of the remaining 10 names have 2 or 3 ways to represent them in a single token

**Note: Derivatives of these names that are not actually the name of the President are not included here. For example: "Obamacare".**

<table border="2"><thead><tr>
<th>Word</th>
<th>Variants</th>
</tr></thead><tbody>
<tr>
  <td style="text-align:left">Adams</td>
  <td style="text-align:left">27329 (' Adams')</td>
<tr>
<tr>
  <td style="text-align:left">Arthur</td>
  <td style="text-align:left">28686 (' Arthur'), 60762 ('Arthur')</td>
<tr>
<tr>
  <td style="text-align:left">Biden</td>
  <td style="text-align:left">38180 (' Biden')</td>
<tr>
<tr>
  <td style="text-align:left">Buchanan</td>
  <td style="text-align:left">85290 (' Buchanan')</td>
<tr>
<tr>
  <td style="text-align:left">Bush</td>
  <td style="text-align:left">14409 (' Bush'), 30773 (' bush'), 100175 ('Bush')</td>
<tr>
<tr>
  <td style="text-align:left">Carter</td>
  <td style="text-align:left">25581 (' Carter')</td>
<tr>
<tr>
  <td style="text-align:left">Cleveland</td>
  <td style="text-align:left">24372 (' Cleveland')</td>
<tr>
<tr>
  <td style="text-align:left">Clinton</td>
  <td style="text-align:left">8283 (' Clinton'), 51308 ('Clinton')</td>
<tr>
<tr>
  <td style="text-align:left">Coolidge</td>
  <td style="text-align:left"></td>
<tr>
<tr>
  <td style="text-align:left">Eisenhower</td>
  <td style="text-align:left">89181 (' Eisenhower')</td>
<tr>
<tr>
  <td style="text-align:left">Fillmore</td>
  <td style="text-align:left"></td>
<tr>
<tr>
  <td style="text-align:left">Ford</td>
  <td style="text-align:left">8350 ('ford'), 14337 (' Ford'), 45728 (' ford'), 59663 ('Ford')</td>
<tr>
<tr>
  <td style="text-align:left">Garfield</td>
  <td style="text-align:left"></td>
<tr>
<tr>
  <td style="text-align:left">Grant</td>
  <td style="text-align:left">13500 (' grant'), 24668 (' Grant'), 52727 ('grant'), 69071 ('Grant')</td>
<tr>
<tr>
  <td style="text-align:left">Harding</td>
  <td style="text-align:left">97593 (' Harding')</td>
<tr>
<tr>
  <td style="text-align:left">Harrison</td>
  <td style="text-align:left">36627 (' Harrison')</td>
<tr>
<tr>
  <td style="text-align:left">Hayes</td>
  <td style="text-align:left">53522 (' Hayes')</td>
<tr>
<tr>
  <td style="text-align:left">Hoover</td>
  <td style="text-align:left">73409 (' Hoover')</td>
<tr>
<tr>
  <td style="text-align:left">Jackson</td>
  <td style="text-align:left">13972 (' Jackson'), 62382 ('Jackson')</td>
<tr>
<tr>
  <td style="text-align:left">Jefferson</td>
  <td style="text-align:left">34644 (' Jefferson')</td>
<tr>
<tr>
  <td style="text-align:left">Johnson</td>
  <td style="text-align:left">11605 (' Johnson'), 63760 ('Johnson')</td>
<tr>
<tr>
  <td style="text-align:left">Kennedy</td>
  <td style="text-align:left">24573 (' Kennedy')</td>
<tr>
<tr>
  <td style="text-align:left">Lincoln</td>
  <td style="text-align:left">25379 (' Lincoln')</td>
<tr>
<tr>
  <td style="text-align:left">Madison</td>
  <td style="text-align:left">31015 (' Madison')</td>
<tr>
<tr>
  <td style="text-align:left">McKinley</td>
  <td style="text-align:left"></td>
<tr>
<tr>
  <td style="text-align:left">Monroe</td>
  <td style="text-align:left">50887 (' Monroe')</td>
<tr>
<tr>
  <td style="text-align:left">Nixon</td>
  <td style="text-align:left">42726 (' Nixon')</td>
<tr>
<tr>
  <td style="text-align:left">Obama</td>
  <td style="text-align:left">7250 (' Obama'), 45437 ('Obama')</td>
<tr>
<tr>
  <td style="text-align:left">Pierce</td>
  <td style="text-align:left">50930 (' Pierce')</td>
<tr>
<tr>
  <td style="text-align:left">Polk</td>
  <td style="text-align:left"></td>
<tr>
<tr>
  <td style="text-align:left">Reagan</td>
  <td style="text-align:left">35226 (' Reagan')</td>
<tr>
<tr>
  <td style="text-align:left">Roosevelt</td>
  <td style="text-align:left">47042 (' Roosevelt')</td>
<tr>
<tr>
  <td style="text-align:left">Taft</td>
  <td style="text-align:left"></td>
<tr>
<tr>
  <td style="text-align:left">Taylor</td>
  <td style="text-align:left">16844 (' Taylor'), 68236 ('Taylor')</td>
<tr>
<tr>
  <td style="text-align:left">Truman</td>
  <td style="text-align:left">80936 (' Truman')</td>
<tr>
<tr>
  <td style="text-align:left">Trump</td>
  <td style="text-align:left">3420 (' Trump'), 16509 ('Trump'), 39155 (' trump')</td>
<tr>
<tr>
  <td style="text-align:left">Tyler</td>
  <td style="text-align:left">32320 (' Tyler'), 100224 ('Tyler')</td>
<tr>
<tr>
  <td style="text-align:left">Van Buren</td>
  <td style="text-align:left"></td>
<tr>
<tr>
  <td style="text-align:left">Washington</td>
  <td style="text-align:left">6652 (' Washington'), 39231 ('Washington'), 94771 (' washington')</td>
<tr>
<tr>
  <td style="text-align:left">Wilson</td>
  <td style="text-align:left">17882 (' Wilson'), 92493 ('Wilson')</td>
<tr>
</tbody>
</table>

## Conclusion

[TODO: Add conclusion]
