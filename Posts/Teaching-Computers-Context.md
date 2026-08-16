---
author: bsstahl
tags:
- ai
- algorithms
- data-structures
- embedding
- ml
- math
categories:
- Development
menuorder: 0
id: 1f872a14-4d10-4c9a-88ae-c84aa84064c2
title: "Teaching Computers Context: Making Meaning Mathematical with Embeddings"
description: An accessible introduction to how embeddings represent concepts as vectors that software can compare and manipulate mathematically.
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2026-08-16T07:00:00Z
lastmodificationdate: 2026-08-16T07:00:00Z
slug: teaching-computers-context

---
## Introduction

Imagine trying to teach a computer the subtle difference between the phrases "I need to address this issue" and "What's your address?" We recognize the intended meaning immediately because we understand the context in which the word is used. A standard text encoding, however, captures the characters in the text, not the concepts those characters represent.

This is the gap that embeddings help us bridge. An embedding represents a concept as a numerical vector, and once we have that mathematical representation, we can compare concepts, group them, and even perform arithmetic on some of their relationships. That is the real power of embeddings: they make aspects of meaning computable.

For example, consider the word "Ram." Depending on its context, it can represent several entirely different concepts:

* Computing: "I'm getting more RAM for my PC" (computer memory)
* Automotive: "I'm getting a Ram so I can pull my boat" (truck model)
* Agriculture: "I'm getting a ram and a ewe" (male sheep)

The characters alone cannot tell us which of these concepts is intended, so how can a computer distinguish among them? An embedding can represent each usage based on the ideas that surround it, giving us a mathematical way to make that distinction.

## From Encoded Text to Represented Meaning

Before a machine learning model can process text, that text must be converted into numerical values. ASCII and UTF encodings represent characters as numbers, while model-specific {PostLink:understanding-gpt-tokenization|tokenization} processes assign numbers to tokens. A model can operate directly on any of these values, but there is an important limitation: the numerical order of the values does not inherently tell us anything about the relationships among the text they represent. Token 101, for example, is not necessarily more similar in meaning to token 102 than it is to token 900.

An embedding gives us an additional, learned representation. It maps a token, word, phrase, sentence, or other item to a vector, which is an ordered list of numbers that we can treat as a point in a high-dimensional space. Unlike the arbitrary relationships implied by the original numeric encoding, the position of this point can capture relationships learned from the data.

Models learn these representations through exposure to large amounts of data. The underlying idea, known as the distributional hypothesis, is that text used in similar contexts tends to have related meanings and should therefore develop related representations. The exact training process varies by model; some models create a single representation for a word, while others create representations that change based on the context. For our purposes, however, the important result is the same: concepts can be placed into a space where we can examine their relationships mathematically.

## Visualizing the 'Ram' Example

Let's return to our three uses of "Ram." To visualize the idea, imagine a deliberately simplified embedding space with only three dimensions, represented as a cube. For this example, the axes correspond to the computing, automotive, and agricultural domains. Real embedding spaces usually have many more dimensions, and those dimensions generally do not have meanings that are this clear or human-readable, but this abstraction gives us a useful place to start.

* "I need to buy more RAM for my PC" would be positioned near concepts such as "Memory," "Storage," and "ROM."
* "I need to buy a Ram to haul my boat" would be positioned near "Truck," "Vehicle," and "Dodge."
* "I put the ram in the pen with the chickens" would be positioned near "Sheep," "Farm," and "Livestock."

Each sentence uses the same three letters, but its embedding occupies a different region of the space because it represents a different concept. We now have something that was not available when the text was merely encoded: a geometry that describes mathematical relationships among meanings.

## Operating on Meaning

Once concepts are represented as vectors, standard mathematical operations become tools for working with meaning. What kinds of operations can we perform, and what can they tell us?

### Measuring Similarity

Distance and similarity calculations tell us how close two vectors are. The embedding for the computing use of "RAM," for example, should be closer to "Memory" than to "Truck," while the automotive use should reverse that relationship. Depending on the model and the task, a system might use Euclidean distance, cosine similarity, a dot product, or another metric. These calculations are not interchangeable in every situation, but each can turn the geometric relationship between vectors into a useful numerical score.

### Finding Groups

Clustering algorithms can identify regions that contain related vectors. Even without explicit labels, a collection might form distinct groups around computing, transportation, and agriculture. A classification system can then compare a new vector with known examples to determine which group it most closely resembles.

### Examining Directions and Arithmetic

The differences between vectors can sometimes capture relationships between concepts, producing familiar examples such as:

* `king - man + woman ≈ queen`
* `paris - france + italy ≈ rome`
* `teacher - school + university ≈ professor`

These analogies illustrate how a direction through the vector space can represent a conceptual relationship. They should not be treated as universal laws; whether they work depends on the model, its training data, and the specific concepts involved. Even with that limitation, they demonstrate a broader and more interesting point: embeddings support more than lookup or comparison. They give us a mathematical structure in which some conceptual relationships can be manipulated.

## What This Makes Possible

These operations are the foundation for many practical systems:

1. **Semantic search** compares the embedding of a query with the embeddings of documents or passages, allowing it to retrieve related ideas even when they use different words.
2. **Classification** compares new text with known categories or examples, supporting scenarios such as sentiment analysis and spam detection.
3. **Clustering and recommendations** group related items and help surface content similar to something a user already values.
4. **Question answering** identifies passages related to a question, recognizing, for example, that "Who created C#?" and "Who is C#'s inventor?" express nearly the same intent.

Of course, putting these ideas into production introduces additional choices. Which embedding model and similarity metric should we use? Should each vector represent a word, a sentence, a paragraph, or some other chunk of content? How will the vectors be stored and searched? Multilingual and multimodal models extend the same geometric approach across languages, images, audio, and other kinds of data. The implementation details vary, but they all build on the same foundation: represent concepts as vectors, then use mathematics to work with their relationships.

## Limitations and Challenges

It is important to remember that embeddings do not contain objective or complete definitions of concepts. They are learned representations shaped by a model's architecture, training data, and objectives. As a result, they can reproduce biases, miss domain-specific meanings, become less useful as language changes, or place concepts together for reasons that are difficult to interpret.

Similarity is also highly dependent on both the model and the task. Two vectors being close together means that a particular model considers them related; it does not explain the relationship or guarantee that the relationship is useful for our scenario. High-dimensional vectors can also require substantial storage and computation at scale. We should therefore evaluate embeddings against the actual task we need to perform rather than assume that geometric elegance guarantees correct results.

## Conclusion

ASCII, UTF, and tokenization make text available to computation by assigning it numbers. Embeddings take us an important step further by giving learned concepts positions in a mathematical space. Within that space, the computing, automotive, and agricultural meanings of "Ram" can occupy different neighborhoods even though the original text is identical.

That shift, from encoded text to represented meaning, is what makes embeddings so powerful. Concepts become vectors, similarity becomes distance, categories become clusters, and some relationships become directions that we can explore using arithmetic. Embeddings do not give computers human understanding, but they do make useful aspects of meaning available to mathematics, and that gives us an extraordinary set of tools for building systems that operate on concepts rather than just characters.
