---
author: bsstahl
tags:
- architecture
- coding-practices
- reliability
menuorder: 0
id: c4e4c620-5bfb-4875-bb53-94cea651a19e
title: Consider Quality Before Cost in Application Development
description: Guidelines on when to consider costs as part of the application development process
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2023-08-02T07:00:00Z
lastmodificationdate: 2023-08-02T07:00:00Z
slug: consider-quality-before-cost
categories:
- Development

---
Measuring the cost of utilizing a particular tool is often simpler than assessing more esoteric costs of an application's life-cycle, such as quality related costs. This can result in an excessive focus on cost optimization, potentially overshadowing vital factors like reliability and maintainability.

As an example, consider a solution that uses a Cosmos DB instance. It is easy to determine how much it costs to use that resource, since the Azure Portal gives us good estimates up-front, and insights as we go. It is much more difficult to determine how much it would cost to build the same functionality without the use of that Cosmos DB instance, and what the scalability and maintainability impacts of that decision would be.

In this article, we will consider a set of high-level guidelines that can help you identify when to consider costs during the development process. By following these guidelines, you can make it more likely that your dev team accurately prioritizes all aspects of the application without falling into the trap of over-valuing easily measurable costs.

## 1. Focus on Quality First

As a developer, your primary objective should be to create applications that meet the customers needs with the desired performance, reliability, scalability, and maintainability characteristics. If we can meet a user need using a pre-packaged solution such as Cosmos DB or MongoDB, we should generally do so. While there are some appropriate considerations regarding cost here, the primary focus of the development team should be on quality.

Using Cosmos DB as an example, we can leverage its global distribution, low-latency, and high-throughput capabilities to build applications that cater to a wide range of user needs. If Cosmos DB solves the current problem effectively, should we really be considering building without it as an alternative for the purpose of cost savings? Part of the answer to that question falls into #2 below, that is, whether or not we consider the use of that tool a best-practice in our organization.

## 2. Employ Best Practices and Expert Advice

During the development of an application, it's essential to follow best practices and consult experts to identify areas for improvement or cost-effectiveness without compromising quality. Since most problems fall into a type that has already been solved many times, the ideal circumstance is that there is already a best-practice for solving problems of the type you are currently facing. If your organization has these best-practices or best-of-breed tools identified, there is usually no need to break-out of that box.

In the context of Cosmos DB, you can refer to Microsoft's performance and optimization guidelines or consult with your own DBAs to ensure efficient partitioning, indexing, and query optimization. For instance, you can seek advice on choosing the appropriate partition key to ensure even data distribution and avoid hot-spots. Additionally, you can discuss the optimal indexing policy to balance the trade-off between query performance and indexing cost.

## 3. Establish Cost Thresholds

Defining acceptable cost limits for different aspects of your application ensures that costs don't spiral out of control while maintaining focus on quality. In the case of Cosmos DB, you can set cost thresholds for throughput (RU/s), storage, and data transfer. For instance, you can define a maximum monthly budget for provisioned throughput based on the expected workload and adjust it as needed. This can help you monitor and control costs without affecting the application's performance. You can also setup alerts to notify you when the costs exceed the defined thresholds, giving you an opportunity to investigate and take corrective action.

Limits can be defined similarly to the way any other SLA is defined, generally by looking at existing systems and determining what normal looks like. This mechanism has the added benefit of treating costs in the same way as other metrics, making it no more or less important than throughput, latency, or uptime.

## 4. Integrate Cost Checks into Code Reviews and Monitoring

A common strategy for managing costs is to introduce another ceremony specifically related to spend, such as a periodic cost review. Instead of creating another mandated set of meetings that tend to shift the focus away from quality, consider incorporating cost-related checks into your existing code review and monitoring processes, so that cost becomes just one term in the overall equation:

- **Code review integration**: During code review sessions, include cost-related best practices along with other quality checks. Encourage developers to highlight any potential cost inefficiencies or violations of best practices that may impact the application's costs in the same way as they highlight other risk factors. Look for circumstances where the use of resources is unusual or wasteful.
- **Utilize tools for cost analysis**: Leverage tools and extensions that can help you analyze and estimate costs within your development environment. For example, you can use Azure Cost Management tools to gain insights into your Cosmos DB usage patterns and costs. Integrating these tools into your development process can help developers become more aware of the cost implications of their code changes, and act in a similar manner to quality analysis tools, making them just another piece of the overall puzzle, instead of a special-case for costs.
- **Include cost-related SLOs**: As part of your performance monitoring, include cost-related SLIs and SLOs, such as cost per request or cost per user, alongside other important metrics like throughput and latency. This will help you keep an eye on costs without overemphasizing them and ensure they are considered alongside other crucial aspects of your application.

## 5. Optimize Only When Necessary

If cost inefficiencies are identified during code reviews or monitoring, assess the trade-offs and determine if optimization is necessary without compromising the application's quality. In Cosmos DB, you can optimize various aspects, such as query performance, indexing policy, and partitioning strategy.

For instance, you can re-evaluate your application's indexing policy to ensure only relevant attributes are indexed, which can help reduce indexing costs. Similarly, you might consider adjusting the partition key if it's causing an uneven data distribution leading to higher consumption of RU/s. If you need to query data in several different ways, you might consider using the Materialized View pattern to make the same data queryable using different partitioning strategies.

## Conclusion

Balancing quality and cost in application development is crucial for building successful applications. By focusing on quality first, employing best practices, establishing cost thresholds, and integrating cost checks into your existing code review and monitoring processes, you can create an environment that considers all costs of application development, without overemphasizing those that are easy to measure.
