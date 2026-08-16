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

Imagine trying to teach a computer the subtle difference between the phrases "I need to address this issue" and "What's your address?" Humans recognize the intended concept from context, but an ordinary text encoding captures characters rather than meaning.

Embeddings bridge that gap by representing concepts as numerical vectors. Once meaning has a mathematical representation, software can compare concepts, group them, and even perform arithmetic on some of their relationships. This is the central power of embeddings: they make aspects of meaning computable.

Consider the word 'Ram'. In different contexts, this word takes on entirely different meanings:

* Computing: "I'm getting more RAM for my PC" (computer memory)
* Automotive: "I'm getting a Ram so I can pull my boat" (truck model)
* Agriculture: "I'm getting a ram and a ewe" (male sheep)

The characters alone do not tell us which concept is intended. An embedding can represent each usage according to the ideas surrounding it.

## From Encoded Text to Represented Meaning

For a machine learning model to process text, the text must first be converted into numerical values. ASCII and UTF encodings represent characters as numbers, while model-specific {PostLink:understanding-gpt-tokenization|tokenization} processes assign numbers to tokens. A model can operate on these values directly, but their numerical order does not inherently describe how the represented text is related. Token 101 is not necessarily more similar in meaning to token 102 than it is to token 900.

An embedding adds a learned representation. It maps a token, word, phrase, sentence, or other item to a vector: an ordered list of numbers that can be treated as a point in a high-dimensional space. The position of that point captures relationships learned from data rather than relationships implied by the original numeric encoding.

Models can learn these representations through exposure to large amounts of data. Following the distributional hypothesis, text used in similar contexts tends to develop related representations. The exact training process varies by model, and some models create one representation for a word while others produce representations that change with context. For our purposes, the important result is the same: concepts can be placed in a space where their relationships can be examined mathematically.

## Visualizing the 'Ram' Example

Return to the three uses of 'Ram'. Imagine a deliberately simplified embedding space with only three dimensions, represented as a cube. In this analogy, the axes correspond to the computing, automotive, and agricultural domains. Real embedding spaces usually have many more dimensions, and individual dimensions generally do not have such clear human-readable meanings.

* 'I need to buy more RAM for my PC' would be positioned near concepts such as 'Memory', 'Storage', and 'ROM'.
* 'I need to buy a Ram to haul my boat' would be positioned near 'Truck', 'Vehicle', and 'Dodge'.
* 'I put the ram in the pen with the chickens' would be positioned near 'Sheep', 'Farm', and 'Livestock'.

Each sentence uses the same three letters, but its embedding occupies a different region because it represents a different concept. That geometry gives us something we did not have when the text was merely encoded: mathematical relationships among meanings.

## Operating on Meaning

Once concepts are represented as vectors, standard mathematical operations become tools for working with meaning.

### Measuring Similarity

Distance and similarity calculations tell us how close two vectors are. The embedding for the computing use of 'RAM' should be closer to 'Memory' than to 'Truck', while the automotive use should reverse that relationship. Depending on the model and task, systems may use Euclidean distance, cosine similarity, a dot product, or another metric. The calculations differ, but each turns the geometric relationship between vectors into a useful numerical score.

### Finding Groups

Clustering algorithms can identify regions containing related vectors. Without being given explicit labels, a collection might form groups around computing, transportation, and agriculture. Classification systems can also compare a new vector with known examples to determine which group it most closely resembles.

### Examining Directions and Arithmetic

Differences between vectors can sometimes capture relationships between concepts. This produces familiar examples such as:

* `king - man + woman ≈ queen`
* `paris - france + italy ≈ rome`
* `teacher - school + university ≈ professor`

These analogies illustrate the possibility of treating a direction through the space as a conceptual relationship. They are not universal laws: their success depends on the model, its training data, and the concepts involved. Still, they reveal the broader idea that embeddings support more than lookup. They provide a mathematical structure in which some relationships can be manipulated.

## What This Makes Possible

These operations support many practical systems:

1. **Semantic search** compares the embedding of a query with embeddings of documents or passages, retrieving related ideas even when they use different words.
2. **Classification** compares new text with known categories or examples, supporting tasks such as sentiment analysis and spam detection.
3. **Clustering and recommendations** group related items and help surface content similar to something a user already values.
4. **Question answering** can identify passages related to a question, such as recognizing that 'Who created Python?' and 'Who is Python's inventor?' express nearly the same intent.

Putting these ideas into production introduces further choices. Systems must select an embedding model and similarity metric, decide how large each chunk should be (word, sentence, paragraph, etc), and determine how vectors will be stored and searched. Multilingual and multimodal models extend the same geometric idea across languages, images, audio, and other kinds of data. Those details vary, but they build on the foundation established here: represent concepts as vectors, then use mathematics to work with their relationships.

## Limitations and Challenges

Embeddings do not contain objective or complete definitions of concepts. They are learned representations shaped by a model's architecture, training data, and objectives. As a result, they can reproduce biases, miss domain-specific meanings, become less useful as language changes, or place concepts together for reasons that are difficult to interpret.

Similarity is also very dempendent on both the model and the task. Two vectors being close together means that the particular model used considers them related; it does not explain the relationship or guarantee that the relationship is useful. High-dimensional vectors can also require substantial storage and computation at scale. Effective systems therefore evaluate embeddings against the real task rather than assuming that geometric elegance guarantees correct results.

## Conclusion

ASCII, UTF, and tokenization make text available to computation by assigning it numbers. Embeddings take a different step: they give learned concepts positions in a mathematical space. In that space, the computing, automotive, and agricultural meanings of 'Ram' can occupy different neighborhoods even though the original text is identical.

That shift from encoded text to represented meaning is what makes embeddings so powerful. Concepts become vectors; similarity becomes distance; categories become clusters; and some relationships become directions that can be explored with arithmetic. Embeddings do not give computers human understanding, but they make useful aspects of meaning available to mathematics.
