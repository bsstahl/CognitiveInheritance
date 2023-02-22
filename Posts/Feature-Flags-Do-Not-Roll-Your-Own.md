---
tags:
- architecture
- coding-practices
menuorder: 0
id: c41a49df-5394-44ff-93a9-62f8c87e89b4
author: bsstahl
title: Feature Flags&colon; Don&apos;t Roll Your Own
description: Rolling your own feature flags comes with complexity, performance, security and maintainability risks, so using an off-the-shelf feature flag management platform is recommended.
ispublished: false
buildifnotpublished: true
showinlist: false
publicationdate: 2023-02-27T07:00:00.000+00:00
lastmodificationdate: 2023-02-27T07:00:00.000+00:00
slug: feature-flags-do-not-roll-your-own
categories:
- Development

---
Feature flags are a powerful tool for controlling the availability and behavior of features in your software. They allow you to turn features on or off at runtime, without deploying new code, and target specific segments of users with different variations of your features. This enables you to experiment, test, and release features faster and safer than ever before.

But feature flags are not something you should implement yourself. Rolling your own feature flags may seem like a simple and cost-effective solution, but it comes with many hidden pitfalls and risks that can undermine your software quality, performance, security, and maintainability. Ultimately, rolling your own feature flag system may end up costing you much more than using an existing product.

We should always have a strong bias against building anything that falls outside of our team's {PostLink:critical-cs-of-microservices-5of6-competencies|core competencies}, but feature flags in particular have their own special set of concerns, especially since, on the surface, it seems like such a simple problem.

Here are some of the specific reasons why you should avoid rolling your own feature flags:

* **Complexity**: Implementing feature flags requires more than just adding some if statements to your code. You need to design a robust system for managing, storing, updating, evaluating, and auditing your feature flags across different environments, platforms, services, and teams. You also need to handle edge cases such as flag dependencies, conflicts, defaults, fallbacks, rollbacks, etc. This adds a lot of complexity and overhead to your codebase that can introduce bugs, errors, inconsistencies, and technical debt.

* **Performance**: Evaluating feature flags at runtime can have a significant impact on your application's performance if not done properly. You need to ensure that your feature flag system is fast, scalable, reliable, resilient, and secure. You also need to optimize your flag evaluation logic for minimal latency and resource consumption. If you roll your own feature flags without proper performance testing and monitoring tools, you may end up slowing down or crashing your application due to excessive network calls, database queries, memory usage, or CPU cycles.

* **Security**: Feature flags can expose sensitive information or functionality that should not be accessible by unauthorized users or attackers. You need to ensure that your feature flag system is secure from both internal and external threats. You also need to comply with any regulatory or legal requirements for data privacy and protection. If you roll your own feature flags without proper security measures and best practices, you may end up leaking confidential data or compromising your application's integrity.

* **Maintainability**: Feature flags are meant to be temporary switches that enable or disable features until they are ready for full release or removal. However, if you roll your own feature flags without proper management tools and processes, you may end up with a large number of stale or unused flags that clutter or pollute your codebase. This makes it harder to understand or modify your code, increases the risk of errors or conflicts, and reduces the readability or testability of your code.

As you can see, rolling your own feature flags is not as easy as it sounds. It requires a lot of time,
effort, skill, and discipline to do it right. And even if you do it right, you may still face challenges such as compatibility issues or vendor lock-in.

That's why you should use a professional feature flag management platform instead. A feature flag management platform provides you with all the tools and services you need to implement and manage feature flags effectively and efficiently.

With a feature flag management platform:

* You can create and update feature flags easily using a user-friendly interface or API.

* You can target specific segments of users based on various criteria such as location, device type, user behavior, etc.

* You can monitor and measure the impact of your features on key metrics such as conversion rates, engagement levels, error rates, etc.

* You can control the rollout speed and strategy of your features using various methods such as percentage-based splits, canary releases, blue-green deployments, etc.

* You can integrate with various tools such as CI/CD pipelines, testing frameworks, analytics platforms, etc. to streamline your development and delivery workflows.

* You can ensure the performance, security, reliability, scalability, of your feature flag system using advanced techniques such as caching, encryption, failover mechanisms, load balancing, etc.

* You can manage the lifecycle of your feature flags using best practices such as naming conventions, documentation, flag retirement policies, etc.

A feature flag management platform takes care of all these aspects for you, so you can focus on building and delivering great features for your customers.

There are many feature flag management platforms available in the market, such as LaunchDarkly, Split, Optimizely, Taplytics, etc. Each platform has its own features, pricing, and integrations that you can compare and choose from based on your needs and preferences.

However, regardless of which platform you use, there are some best practices that you should follow when using feature flags. These best practices will help you avoid common pitfalls and maximize the benefits of feature flags for your software development and delivery process.

Here are some of the best practices that you should know:

* **Use a consistent system for feature flag management**: It doesn't matter if you use a feature flag management tool or a custom solution, as long as you have a consistent system for creating, updating, and deleting your feature flags. You should also have a clear ownership and accountability model for each flag, so that you know who is responsible for what.

* **Set naming conventions for different types of feature flags**: You can implement feature flags to achieve many different goals, such as testing, experimenting, releasing, or hiding features. You should use descriptive and meaningful names for your flags that indicate their purpose and scope. You should also use prefixes or suffixes to distinguish between different types of flags, such as release flags, experiment flags, kill switches, etc.

* **Make it easy to switch a flag on/off**: You should be able to turn a feature flag on or off with minimal effort and delay. You should also be able to override or modify a flag's settings at any time without redeploying your code. This will allow you to react quickly and flexibly to any changes or issues that may arise during your feature development or delivery cycle.

* **Make feature flag settings visible**: You should be able to see and monitor the current state and configuration of each feature flag at any given time. You should also be able to track and audit the history and usage of each flag across different environments, platforms, services, and teams. This will help you ensure transparency and traceability of your feature development and delivery process.

* **Clean up obsolete flags**: You should remove any feature flags that are no longer needed or used as soon as possible. This will prevent cluttering or polluting your codebase with unnecessary or outdated code paths that can increase complexity or introduce errors or conflicts¹⁶.

Some additional recommendations are:

* **Avoid dependencies between flags**: You should avoid creating complex dependencies or interactions between different feature flags that can make it hard to understand or predict their behavior or impact. You should also avoid nesting or chaining multiple flags within each other that can increase latency or resource consumption.

* **Use feature switches to avoid code branches**: You should use simple boolean expressions to evaluate your feature flags rather than creating multiple code branches with if/else statements. This will reduce code duplication and improve readability and testability of your code.

* **Use feature flags for small test releases**: You should use feature flags to release small batches of features incrementally rather than releasing large groups of features altogether. This will allow you to test and validate your features with real users in production without affecting everyone at once. It will also enable you to roll back or fix any issues quickly if something goes wrong[^1]^ [8]^.

By following these best practices, you can leverage the power of feature flags without compromising on quality, performance, security, or maintainability.

#### Some Open Source Feature Flag Systems

Yes, there are some open source projects that support feature flag management. For example:

* **GrowthBook**: GrowthBook is an open source feature management and experimentation platform that helps your engineering team adopt an experimentation culture. It enables you to create gradual or canary releases with user targeting, run A/B tests, track key metrics, and integrate with various data sources.

* **Flagsmith**: Flagsmith is an open source feature flag and remote config service that makes it easy to create and manage features flags across web, mobile, and server side applications. It allows you to control feature access, segment users, toggle features on/off, and customize your app behavior without redeploying your code.

* **Unleash**: Unleash is an open source feature flag management system that helps you deploy new features at incredible speed. It lets you decouple deployment from release, run experiments easily, scale as your business grows, and integrate with various tools and platforms.

These are just some examples of open source feature flag management projects. There may be others that suit your needs better.

Feature flags are an essential tool for modern software development and delivery. They enable you to deliver faster, safer, and better features for your customers while reducing risk and cost. But don't try to roll your own feature flags unless you have a good reason and enough resources to do so. Instead, use a professional feature flag management platform that provides you with all the tools and services you need to implement and manage feature  flags effectively  and efficiently.
