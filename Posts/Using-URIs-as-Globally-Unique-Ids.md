---
tags:
- architecture
- coding-practices
menuorder: 0
id: 3381f760-a4f1-4335-b7c5-3b1da1ff85c0
author: bsstahl
title: Using URIs as Globally Unique Identifiers
description: Learn how URIs provide a robust solution for creating unique, self-describing identifiers while avoiding the pitfalls of composite IDs. This comprehensive guide covers implementation best practices, common anti-patterns, and real-world examples.
ispublished: false
buildifnotpublished: true
showinlist: false
publicationdate: 2025-01-29T07:00:00.000+00:00
lastmodificationdate: 2025-01-29T07:00:00.000+00:00
slug: using-uris-as-globally-unique-ids
categories:
- Development

---
In our companion article on [The ID Entanglement Effect](the-id-entanglement-effect), we explored the challenges and risks of using composite IDs that encode business logic or mutable state. A powerful alternative that addresses many of these concerns is the use of URIs (Uniform Resource Identifiers) as identifiers. URIs provide a standardized way to create unique, self-describing identifiers while avoiding the pitfalls of traditional composite IDs.

### Benefits of URI-Based Identifiers

* _Global Uniqueness_: URIs provide natural namespace separation through domain names and paths (e.g., `https://example.com/employees/12345`). This eliminates ID conflicts across systems and organizations without requiring complex prefixing schemes.

* _Standard Format_: URIs follow well-defined standards (RFC 3986) with robust parsing libraries available in every major programming language. This standardization means teams don't need to create and maintain custom parsing logic.

* _Self-Describing_: URIs can convey meaning through their structure without requiring parsing of the identifier itself. For example, `https://api.example.com/orders/2024/01/12345` clearly indicates an order resource while maintaining a clean separation between the identifier and its metadata.

* _Extensible_: New properties can be added through query parameters without breaking existing systems. For instance, `https://api.example.com/products/12345?version=2` can introduce versioning without changing the base identifier.

* _Interoperable_: URIs work seamlessly across different systems and protocols, making them ideal for distributed systems and microservices architectures.

### Implementation Guidelines

When implementing URI-based identifiers, consider these best practices:

1. **Keep Base URIs Stable**
   - Choose domain names and base paths that won't need to change
   - Use dedicated subdomains for different environments (e.g., `api.example.com`, `test-api.example.com`)
   - Consider using URNs (e.g., `urn:example:order:12345`) for purely internal identifiers

2. **Structure Meaningful Paths**
   - Use clear resource types in paths (`/orders/`, `/customers/`, `/products/`)
   - Include version information in the path if needed (`/v1/orders/`)
   - Keep path segments simple and consistent

3. **Use Appropriate Identifiers**
   - UUIDs work well for unique segments (`/orders/550e8400-e29b-41d4-a716-446655440000`)
   - Short, random strings can be more user-friendly (`/products/xy7z9`)
   - Avoid sequential numbers to prevent enumeration attacks

4. **Handle Query Parameters Carefully**
   - Use query parameters for optional metadata only
   - Never include mutable state in the base URI
   - Document which parameters are part of the identifier

### Common Anti-Patterns to Avoid

1. **Encoding Mutable Data**
   ```
   # Bad: Including status in URI
   https://api.example.com/orders/active/12345

   # Good: Status as a property
   https://api.example.com/orders/12345
   ```

2. **Deep Hierarchical Nesting**
   ```
   # Bad: Deep nesting creates brittleness
   https://api.example.com/departments/sales/regions/west/employees/12345

   # Good: Flat structure with relationships
   https://api.example.com/employees/12345
   ```

3. **Overloading Query Parameters**
   ```
   # Bad: Essential data in query parameters
   https://api.example.com/products?category=electronics&id=12345

   # Good: Clean resource path
   https://api.example.com/products/12345
   ```

### Real-World Examples

1. **E-Commerce System**
   ```
   # Order ID
   https://shop.example.com/orders/2024/550e8400-e29b-41d4-a716-446655440000

   # Product ID
   https://shop.example.com/products/electronics/laptop-x1
   ```

2. **Content Management System**
   ```
   # Article ID
   https://cms.example.com/articles/2024/01/using-uris-as-ids

   # Asset ID
   https://cms.example.com/assets/images/header-logo
   ```

3. **Microservices Architecture**
   ```
   # Customer Service
   https://customers.example.com/v1/profiles/12345

   # Inventory Service
   https://inventory.example.com/v1/items/in-stock/89abc
   ```

### Storage Considerations

When storing URI identifiers:

1. **Database Design**
   - Use VARCHAR/TEXT columns with appropriate length
   - Consider indexing for performance
   - Validate URI format before storage

2. **Normalization**
   - Store canonical forms (lowercase, no trailing slashes)
   - Consider storing components separately if needed
   - Document normalization rules

3. **Performance**
   - Use proper indexing strategies
   - Consider URI length limits
   - Cache frequently accessed resources

### Migration Strategies

When moving to URI-based identifiers:

1. Start with new resources
2. Create URI aliases for existing IDs
3. Gradually transition systems to use URIs
4. Maintain backwards compatibility during transition
5. Document both old and new formats

### Conclusion

URI-based identifiers offer a robust solution to many of the challenges posed by traditional composite IDs. By following established standards and best practices, teams can create scalable, maintainable systems that avoid the ID Entanglement Effect while maintaining flexibility for future growth.

Remember that URIs are not just for web resources - they provide a standardized format for creating unique, self-describing identifiers in any system. Whether you're building a distributed microservices architecture or a monolithic application, URI-based identifiers can help create cleaner, more maintainable code.
