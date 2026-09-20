---
author: bsstahl
tags:
- book
categories:
- Development
menuorder: 0
id: faa210e7-62cf-4908-b1a3-92558cc2befb
title: Signals & Levers&colon; Systems Thinking for Software Architects
description: A look at the systems‑thinking tools from the book, Signals & Levers and how they apply to software‑intensive systems. Using the book’s vocabulary of signals, levers, feedback loops, and causal structure, we look at how distributed software behaves under load, contention, and failure. The goal is to show how those same mental models illuminate queues, retries, backpressure, cascading failures, and other real operational dynamics inside modern software.
teaser: 
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2026-09-20T07:00:00Z
lastmodificationdate: 2026-09-20T00:00:00Z
slug: signals-and-levers

---

* **Intro**  
  * Describe why I loved this book and how it connected the dots for me on several of the key concepts.
  * Frame the post as applying *Signals & Levers* to software‑intensive systems.  
  * Emphasize shared exploration: using the book’s vocabulary to understand runtime behavior.

* **Why the book’s tools matter here**  
  * Signals, levers, feedback loops, causal structure.  
  * These concepts translate cleanly from human systems to distributed software systems.

* **Signals in software‑intensive systems**  
  * Latency drift  
  * Queue depth acceleration  
  * Retry spikes  
  * Timeout variance  
  * Cache‑miss rise  
  * Pool saturation  
  * Autoscaling oscillation  
  * Downstream latency correlation

* **Levers in software‑intensive systems**  
  * Backpressure  
  * Retry shaping  
  * Circuit breakers  
  * Autoscaling tuning  
  * Queue partitioning  
  * Cache TTL adjustments  
  * Load shedding  
  * Concurrency limits  
  * Dependency isolation

* **Feedback loops and causal structure**  
  * Reinforcing loops: retry storms, cache spirals, contention cascades.  
  * Balancing loops: backpressure, circuit breakers, congestion control.  
  * Time delays: autoscaling warmup, telemetry lag, queueing delay.  
  * Stocks/flows: queues, in‑flight requests, retries, resource pools.

* **Bus maintenance domain: data inconsistencies from dual‑writes**  
  * Describe the bus maintenance scenario and the periodic data inconsistencies.  
  * Identify the dual‑writes anti‑pattern as a suspected source.  
  * List key signals: inconsistency rate, write latency, retry behavior, replication lag.

* **Causal‑loop diagram for the bus maintenance system**  
  * Map reinforcing loops: retries, conflicting writes, inconsistency amplification.  
  * Map balancing loops: validation checks, reconciliation jobs, backpressure.  
  * Highlight time delays: reconciliation intervals, replication delays, monitoring lag.  
  * Show how dual‑writes sit inside these loops.

* **Designing experiments (pulling levers)**  
  * Adjust retry policies and observe inconsistency frequency.  
  * Introduce or tighten write ordering / single‑writer constraints.  
  * Change reconciliation cadence or strategy.  
  * Measure how each lever affects the signals and loops.

* **Closing**  
  * Connect the example back to *Signals & Levers*: same tools for any domain.
  * Invite readers to use the same vocabulary to understand their own systems, sofware or otherwise.
