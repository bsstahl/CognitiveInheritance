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

## BPE Tokenization in natural language processing (NLP)

BPE (Byte-Pair Encoding) Tokenization is the process of converting text input into a numeric form that machine learning models can interpret. During this process, text strings are broken into segments, usually words or word-segments; and then segments are iteratively merged with the following segments based on the commonality of their usage. Eventually, these merged segments are mapped to one or more unique integer values called tokens. This numerical representation allows algorithms to perform operations on textual data since the models require quantitative inputs.

### Why Tokenization?

NLP models utilize tokenization over direct UTF-8 byte representation because tokens offer linguistic units that more meaningfully align with the way language is structured and understood. Tokens abstract text into discrete elements that capture semantics, enable better generalization, and facilitate sequence processing. This approach simplifies the complexity inherent in multi-byte characters and enhances model efficiency by reducing the input space. Consequently, tokenization leads to more compact, contextually aware, and semantically rich representations that are useful for the pattern recognition tasks required in NLP.

### The *cl100k* Tokenization Model

The *cl100k* tokenization model is the encoding scheme employed by OpenAI's GPT (Generative Pre-trained Transformer) models. This encoding is built to parse input text into 100,256 (100k) different tokens, efficiently representing a vast range of linguistic elements from individual characters to full words and phrases in numerous languages and alphabets. This approach allows GPT models to grasp the nuances of language, handle a variety of linguistic tasks, and generate coherent, contextually relevant text based on the input they receive. The *cl100k* tokenizer is an integral part of how GPT models manage to achieve their impressive performance in generating human-like text.

## The *cl100k* Tokenizer Sample Code

I found it difficult to understand the tokenization process from looking at the code for some of the standard implementations. There is a simple reason for this -- those implementations are optimized for speed and efficiency, not for clarity and understanding. To solve this problem, and help my understanding of this process, I created a new implementation using an object-oriented approach. This implementation prioritizes clarity over performance, making the concepts of encoding and decoding with *cl100k* far more accessible for educational purposes. This approach allows learners to investigate the nuances of tokenization without getting lost in the weeds of complex array operations. The code is written in *C#* and is available on [GitHub](https://github.com/bsstahl/AIDemos/tree/master/Tokenizer).

### *cl100k* Tokenization Replacements

The key to the tokenization process using *cl100k* is the replacements data, found in the [cl100k_base.tiktoken file](https://github.com/bsstahl/AIDemos/blob/master/Tokenizer/Tokenizer/data/cl100k_base.tiktoken) in the code sample. This file contains a list of Base-64 encoded strings, and the token that each string represents. A decoded version of this file can be found in {PageLink:cl100k-token-replacements|this table}.

[TODO: Walk throught the sample code, explaining how the Encode and Decode methods work]

### Invalid UTF-8 Sequences

One of the things that concerned me when learning about this process was the fact that a number of tokens translated to invalid UTF-8 sequences. This didn't seem right since all input text is encoded as UTF-8 characters. One thing I've learned as an Engineer, if something seems off or doesn't make sense, it means there is a much greater liklihood of something being actually wrong, either in my implementation or my understanding of the process.

Fortunately this particular oddity is not actually indicative a problem, but is instead an artifact of the training and encoding processes that generally only occurs during the use of characters other than those typically used in English.

I will explain with an example using token *1717*. This token is replaced by the byte sequence *0x20 0xC3*, which is a space character followed by a byte that does not represent valid UTF-8 on its own. This would be a problem if this token were ever used by itself or at the end of a sequence of tokens since that would leave a byte hanging that couldn't be translated into UTF-8. However, there is no way for a token like this to be used by itself or at the end of a sequence as long as the text it is representing has been properly encoded as UTF-8. Instead, such a token is always followed by at least one additional token, which will result in one or more valid UTF-8 characters.

If for our example, the *1717* token is followed by token *104* (*0xAB* -- also invalid on its own), it combines with the *0xC3* left over from the *1717* token, forming the sequence *0xC3 0xAB*, which is the UTF-8 character "ë". Similarly, if *1717* were combined with token *109* (*0xB1* -- again invalid Unicode), we'd get the sequence *0xC3 0xB1*, the Spanish character "ñ".

This means that if we encode the Spanish exclamation "Vaya, ñu" ("Wow, wildebeest") into tokens, we would get the sequence *[53,12874,11,1717,109,84]*. Note the *1717,109* combination towards the end of the squence. These integers represent a set of UTF-8 characters that are encoded into tokens where the tokens can't all be translated to valid UTF-8 characters individually.

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
* 20 have only 1 way to represent their name in a single token; with a leading space and initial cap
* 8 have 2 ways to represent the name in a single token; an initial cap, with and without a leading space
* 3 presidents have 3 ways to represent their name in a single token
* Ford and Grant have all 4 possible ways

The fact that Ford and Grant have the most ways to represent their names makes sense since there are so many other reasons to write those words other than to mean the name of the President. The Presidents where the name cannot be represented in a single token generally indicates the lack of mentions of these Presidents in the training data. Since the corpus of training data is from the Internet, it makes sense that the Presidents who have a lower cultural significance in the Internet era would be less likely to have their names represented in a single token. Thus, Presidents Coolidge, Fillmore, Garfield, McKinley, Polk, Taft, and Van Buren all require more than one token to represent their names in any form. These names are also less likely to be represented in the training data as a reference to someone or something else.

Meanwhile, names like Washington, Jefferson, and Johnson, which are more common in the English language, have multiple representations in a single token. This is likely due to the frequency of these names in the US population, which in itself is a nod to the historical and cultural significance of the Presidents themselves.

**Note: Derivatives of these names that are not actually the name of the President are not included here. For example: "Obamacare".**

<table border="2">
  <thead>
    <tr>
      <th>President</th>
      <th>Tokens</th>
    </tr>
  </thead>
  <tbody>
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
<br/>

## Conclusion

[TODO: Add conclusion]
