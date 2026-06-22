---
author: bsstahl
tags:
- dependency-injection
categories:
- Development
menuorder: 0
id: 65b802d4-1ba9-4a87-817d-50c57dd4fbcc
title: DI Issues in Azure Functions Isolated Worker
description: An explanation of why dependency injection behaves differently in the Azure Functions .NET isolated worker model when using `FunctionsApplication.CreateBuilder`. Function classes are not created through the DI container, so constructor injection does not apply to arbitrary services. Instead, the Functions runtime instantiates function classes itself, and the actual DI container is only available at invocation time through `FunctionContext.InstanceServices`.
ispublished: false
showinlist: false
buildifnotpublished: true
publicationdate: 2026-06-22T07:00:00Z
lastmodificationdate: 2026-06-22T07:00:00Z
slug: azure-functions-di

---

## Summary

In the .NET isolated worker model using `FunctionsApplication.CreateBuilder(args)`, I expected to resolve DI‑registered services (including `ILogger<T>`) directly inside my function class. Instead, `ILogger<T>`, or any `[FromServices]` retrieved dependency, was always coming back **null**, even though the Functions runtime clearly logs correctly and injects loggers and other dependencies into function constructors.

The issue wasn’t configuration — it was **where** I was trying to resolve dependencies from.

## Root Cause

In the new isolated worker hosting model:

```csharp
var builder = FunctionsApplication.CreateBuilder(args);
```

the function class itself is **not** created by the DI container.  
It is created by the **Functions Worker**, using its own activator.

Because of that:

- The function class **does not receive DI constructor injection** for arbitrary services.
- The DI container **is not directly available** inside the function unless I explicitly request it.
- Trying to resolve services directly inside the function (e.g., via constructor injection) **does not work**.

However, the DI container *is* available — just not where I originally looked.

## Key Insight

Every function invocation receives a `FunctionContext`.

`FunctionContext` exposes the DI container through:

```csharp
context.InstanceServices
```

This is the **actual** service provider used by the isolated worker.

## The Fix

Instead of trying to inject services directly into the function class, I resolve them from the `FunctionContext`:

```csharp
public class MyFunction
{
    [Function("MyFunction")]
    public async Task RunAsync(
        [TimerTrigger("0 */5 * * * *")] TimerInfo timer,
        FunctionContext context)
    {
        var services = context.InstanceServices;

        var myService = services.GetRequiredService<IMyService>();
        var logger = services.GetRequiredService<ILogger<MyFunction>>();

        logger.LogInformation("Function started");
        await myService.DoWorkAsync();
    }
}
```

## Why This Works

- The isolated worker creates the function class itself (not DI), so constructor injection into the function class is limited.
- The DI container *is* populated correctly — including `ILogger<T>` — but only accessible through `FunctionContext.InstanceServices`.
- Resolving dependencies from `InstanceServices` ensures I’m using the same container the worker uses internally.

## When to Use This Pattern

Use `FunctionContext.InstanceServices` when:

- You need DI‑registered services inside the function method.
- You want `ILogger<T>` inside the function but constructor injection isn’t working.
- You want to keep the function class thin and resolve dependencies per invocation.

## When NOT to Use It

If you want full constructor injection into the function class itself, you must use the older:

```csharp
new HostBuilder().ConfigureFunctionsWorkerDefaults()
```

pattern — **not** the new `FunctionsApplication.CreateBuilder` model.
