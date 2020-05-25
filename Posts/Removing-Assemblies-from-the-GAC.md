---
tags:
- clr
- gac
- assembly
- strong name
menuorder: 0
id: 567d54a3-06c2-4939-9655-6d045be217fb
author: bsstahl
title: Removing Assemblies from the GAC
description: 
ispublished: true
showinlist: false
publicationdate: 2007-07-01T16:51:00
lastmodificationdate: 2010-10-22T18:11:27
slug: Removing-Assemblies-from-the-GAC
categoryids:
- da73f25e-343d-4a0e-9b28-1d76e8fd99bf

---

I recently stumbled across an interesting item in a back-issue of MSDN Magazine. The article, ["Improving Application Startup Time" by Claudio Caldato](http://msdn.microsoft.com/msdnmag/issues/06/02/clrinsideout/), appeared in the CLR Inside Out segment in February 2006. While discussing strong-named assemblies, Claudio recommended adding them to the GAC for performance.


> If an assembly is not installed in the Global Assembly Cache (GAC), you will pay the cost of hash verification of strong-named assemblies along with native code generation (NGEN) image validation if a native image for that assembly is available in the machine. In other words, if an assembly is strong named, the CLR will ensure the integrity of the assembly binary by verifying that the cryptographic hash of the assembly matches the one in the assembly manifest. But if the assembly is in the GAC, this verification can be skipped because the verification is performed as part of installation into the GAC and any update requires administrative permissions. So the CLR is basically assured that changes have not occurred.
> 
> The hash verification process is expensive because it involves touching every page in the assembly, which can be bad for cold startup. Also, the hash computation is CPU-intensive and thus impacts warm startup, too. The extent of the impact depends on the size of the assembly being verified.
> 
> If an assembly has been precompiled using NGEN but it is not installed in the GAC, then during binding, fusion needs to verify that the native image and the MSIL assembly are the same version (to avoid cases where a newer version of the assembly is deployed on the machine but a newer version of the native image is not generated). In order to accomplish that, the CLR needs to access pages in the MSIL assembly, which can hurt cold startup time.


I found this particularly interesting because I generally do not recommend putting assemblies into the GAC unless there is a particular need. The GAC is a very useful and powerful tool, but it does add complexity to the deployment of applications, occasionally limiting the frequency with which applications can be deployed, and often increasing the testing requirements for deployment of applications that use shared assemblies. As a result, I usually avoid putting assemblies in the GAC unless they truly need to be there (such as shared .dlls in applications that require that they be using the same version of the assembly). I have also heard of people pulling assemblies that were installed in the GAC, back out into bin-folder type deployments in order to simplify the deployment process.

The information from this article adds a wrinkle to the process of removing assemblies from the GAC because it makes the best-practice for doing so include the removal of the strong-name (which was required for inclusion in the GAC). As a result, there may be a performance penalty incurred at each application startup for these apps if the strong-name is left in place. Since removal of the strong-name will not always be possible, this is certainly something to consider. While I doubt that this could cause enough of a performance decrease by itself to make it worth keeping assemblies in the GAC that would otherwise be removed, it is a fact worth knowing, and more importantly, worth testing when considering such a move.

