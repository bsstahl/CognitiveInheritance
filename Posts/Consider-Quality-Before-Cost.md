---
author: bsstahl
tags:
- architecture
- coding-practices
- reliability
categories:
- development
menuorder: 0
id: 
title: Consider Quality Before Cost in Application Development
description: 
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2023-08-02T07:00:00Z
lastmodificationdate: 2023-08-02T07:00:00Z
slug: consider-quality-before-cost

---
It is usually easier to measure the cost of using a certain tool than it is to measure the harder-to-quantify aspects of the development process such as quality. This can sometimes lead to an overemphasis on cost optimization at the expense of arguably more important factors like reliability and maintainability.

As an example, consider a CosmosDB instance. It is easy to see how much it costs to use that resource, since the Azure Portal gives us good estimates up-front, and insights as we go. It is much more difficult to determine how much it will cost to build the same functionality without the use of that CosmosDB instance, and what the scalability and maintainability impacts of that decision will be.

In this blog post, we will consider a set of high-level guidelines that can help you identify when to consider costs during the development process. By following these guidelines, you can make it more likely that your dev team considers the correct aspects of the application without falling into the trap of prioritizing easily measurable costs over quality.

## 1. Focus on Quality First

As a developer, your primary objective should be to create applications that meet desired performance, scalability, and maintainability requirements. With Cosmos DB, for example, you can leverage its global distribution, low-latency, and high-throughput capabilities to build applications that cater to a wide range of user needs.

## 2. Employ Best Practices and Expert Advice

During the design phase, it's essential to follow best practices and consult experts to identify areas for improvement or cost-effectiveness without compromising quality. In the context of CosmosDB, you can refer to Microsoft's performance and optimization guidelines or consult with the data team to ensure efficient partitioning, indexing, and query optimization.

For instance, you can seek advice on choosing the appropriate partition key to ensure even data distribution and avoid hotspots. Additionally, you can discuss the optimal indexing policy to balance the trade-off between query performance and indexing cost.

## 3. Establish Cost Thresholds

Defining acceptable cost limits for different aspects of your application ensures that costs don't spiral out of control while maintaining focus on quality. In the case of Cosmos DB, you can set cost thresholds for throughput (RU/s), storage, and data transfer.

For instance, you can define a maximum monthly budget for provisioned throughput based on the expected workload and adjust it as needed. This can help you monitor and control costs without affecting the application's performance.

## 4. Integrate Cost Checks into Code Reviews and Monitoring

A common strategy for managing costs is to introduce another ceremony specifically for costs, such as a periodic cost review. Instead of introducing another mandated set of meetings that tend to shift the focus away from quality, consider incorporating cost-related checks into your existing code review and monitoring processes, so that cost become just one term in the overall equation:

- **Code review integration**: During code review sessions, include cost-related best practices along with other quality checks. Encourage developers to highlight any potential cost inefficiencies or violations of best practices that may impact the application's costs.
- **Utilize tools for cost analysis**: Leverage tools and extensions that can help you analyze and estimate costs within your development environment. For example, you can use Azure Cost Management tools to gain insights into your Cosmos DB usage patterns and costs. Integrating these tools into your development process can help developers become more aware of the cost implications of their code changes.
- **Include cost-related KPIs**: As part of your performance monitoring, include cost-related KPIs, such as cost per request or cost per user, alongside other important metrics like throughput and latency. This will help you keep an eye on costs without overemphasizing them and ensure they are considered alongside other crucial aspects of your application.

## 5. Optimize When Necessary

If cost inefficiencies are identified during code reviews or monitoring, assess the trade-offs and determine if optimization is necessary without compromising the application's quality. In Cosmos DB, you can optimize various aspects, such as query performance, indexing policy, and partitioning strategy.

For instance, you can re-evaluate your application's indexing policy to ensure only relevant attributes are indexed, which can help reduce indexing costs. Similarly, you might consider adjusting the partition key if it's causing an uneven data distribution leading to higher consumption of RU/s. If you need to query data in several different ways, you might consider the Materialized View pattern to make the same data queryable using different partitioning strategies.

## Conclusion

Balancing quality and cost in application development is crucial for building successful applications. By focusing on quality first, employing best practices, establishing cost thresholds, and integrating cost checks into your existing code review and monitoring processes, you can develop top-quality applications using Cosmos DB without compromising on cost efficiency.