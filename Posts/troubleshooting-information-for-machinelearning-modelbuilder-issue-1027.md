---
author: bsstahl
tags:
- ml
- modelbuilder
categories:
- Tools
menuorder: 
id: f7d71577-57c3-4676-a5fa-2745a2bb8cf7
title: 'Troubleshooting Information for Machinelearning-ModelBuilder Issue #1027'
description: 'Information that can be used to troubleshoot Issue #1027 in the Machinelearning-ModelBuilder
  Repository'
ispublished: true
showinlist: false
publicationdate: 2021-04-30T18:00:00.000+00:00
lastmodificationdate: 2021-04-30T18:00:00.000+00:00
slug: Troubleshooting-Machine-Learning-ModelBuilder-Issue-1027

---
There appears to be a problem with the *Preview* version of the ModelBuilder tool for Visual Studio. This issue has been logged on [GitHub](https://github.com/dotnet/machinelearning-modelbuilder/issues/1027) and I am documenting my findings here in the hope that they will provide some insight into the problem. I will update this post when a solution or workaround is found.

I want to be clear that this problem is in a **preview version**, where problems like this are expected. I don't want the team working on this tooling to think that I am being reproachful of their work in any way. In fact, I want to compliment them and thank them for what is generally an extremely valuable tool.

To reproduce this problem, use this [Data File](https://gist.githubusercontent.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/7466eb3f60fe881300de004954b240950069675d/SourceData_Mocked.csv) to train an **Issue Classification** or **Text Classification** model in the ModelBuilder tool by using the *Key* column to predict the *Value* column. The keys have intelligence built into them that are valid predictors of the Value (I didn't design this stuff).

Machines that are unable to complete this task get a error stating `Specified label column 'Value' was not found.` with a stack trace similar to [this](https://gist.githubusercontent.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/52e01628cb6f449fd95091eaa033559a6c4b386e/StackTrace.txt).

This process seems to work fine on some machines and not on others. I have a machine that it works on, and one that it fails on, so I will attempt to document the differences here.

The first thing I noticed is that the experience within the tool is *VERY DIFFERENT* even though it is using the exact same version of the Model Builder.

### From the machine that is able to train the model

![Scenarios - Functional Machine](https://gist.github.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/b73f673ab81247a529e419e56e1441b6b3cc099b/FunctionalMachine_ModelBuilder_Scenario.png)

### From the machine having the failure

![Scenarios - Failing Machine](https://gist.github.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/b73f673ab81247a529e419e56e1441b6b3cc099b/ProblemMachine_ModelBuilder_Scenario.png)

Everything seems to be different. The headline text, the options that can be chosen, and the graphics (or lack thereof). My first reaction when I saw this was to double-check that both machines are actually using the same version of the Model Builder tool.

## Verifying the Version of the Tool

Spoiler alert: **To the best I am able to verify, both machines are using the same version of the tool**.

### From the machine that is able to train the model

![ModelBuilder Tool Version - Functional Machine](https://gist.github.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/28226dc3fccf0155815f323a484146b7fc662305/FunctionalMachine_ModelBuilder_Version.png)

### From the machine having the failure

![ModelBuilder Tool Version - Failing Machine](https://gist.github.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/28226dc3fccf0155815f323a484146b7fc662305/ProblemMachine_ModelBuilder_Version.png)

My next thought is that I'm not looking at the right thing. Perhaps, **ML.NET Model Builder (Preview)** is not the correct Extension, or maybe the UI for this Extension is loaded separately from the Extension. I can't be sure, but I can't find anything that suggests this is really the case. Perhaps the dev team can give me some insight here.

## Verifying the Region Settings of the Machine

While these versions are clearly the same, it is obvious from the graphics that the machines have different default date formats. Even though there are no dates in this data file, and both machines were using *US English*, I changed the Region settings of the problem machine to match that of the functional machine. Predictably, this didn't solve the problem.

### From the machine that is able to train the model

![Region Settings - Functional Machine](https://gist.github.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/28226dc3fccf0155815f323a484146b7fc662305/FunctionalMachine_Region.png)

### From the machine having the failure - Original Settings

![Region Settings - Problem Machine](https://gist.github.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/28226dc3fccf0155815f323a484146b7fc662305/ProblemMachine_Region.png)

### From the machine having the failure - Updated Settings

![Updated Region Settings - Problem Machine](https://gist.github.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/28226dc3fccf0155815f323a484146b7fc662305/ProblemMachine_Region_Updated.png)

## Checking the Versions of Visual Studio

The biggest difference between the two machines that I can think of, now that the region settings match, is the exact version & configuration of Visual Studio. Both machines have **Visual Studio Enterprise 2019 Preview** versions, but the working machine has version *16.9.0 Preview 1.0* while the failing machine uses version *16.10.0 Preview 1.0*. You'll have to forgive me for not wanting to "upgrade" my working machine to the latest preview of Visual Studio, just in case that actually is the problem, though I suspect that is not the issue.

### From the machine that is able to train the model

![Visual Studio Version - Functional Machine](https://gist.github.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/7466eb3f60fe881300de004954b240950069675d/FunctionalMachine_VisualStudio.png)

### From the machine having the failure

![Visual Studio Version - Problem Machine](https://gist.github.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/7466eb3f60fe881300de004954b240950069675d/ProblemMachine_VisualStudio.png)

There are also differences in the installed payloads within Visual Studio between the 2 machines. Files containing information about the installations on each of the machines can be found below. These are the files produced when you click the *Copy Info* button from the Visual Studio *About* dialog.

### From the machine that is able to train the model

[Visual Studio Payloads - Functional Machine](https://gist.githubusercontent.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/7466eb3f60fe881300de004954b240950069675d/VisualStudioPayloads_FunctionalMachine.txt)

### From the machine having the failure

[Visual Studio Payloads - Problem Machine](https://gist.githubusercontent.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/7466eb3f60fe881300de004954b240950069675d/VisualStudioPayloads_ProblemMachine.txt)

## Windows Version

Another set of differences involve the machines themselves and the versions of Windows they are running. Both machines are running Windows 10, but the working machine runs a **Pro** sku, while the problem machine uses an **Enterprise** sku. Additionally, the machines have different specs, though they are consistent in that they are both underpowered for what I do. I'm going to have to remedy that.

I've included some of the key information about the machines and their OS installations in the files below. None of it seems particularly probative to me.

### From the machine that is able to train the model

[System and OS - Functional Machine](https://gist.githubusercontent.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/c5148816444cca781a0ea428d5ed5a58bc6fc434/Windows_FunctionalMachine.txt)

### From the machine having the failure

[System and OS - Problem Machine](https://gist.githubusercontent.com/bsstahl/06db6cfce2fbbc2e6d455631ffff8108/raw/c5148816444cca781a0ea428d5ed5a58bc6fc434/Windows_ProblemMachine.txt)

## Other Things to Check

There are probably quite a number of additional differences I could look at between the 2 machines. Do you have any ideas about what else I could check to give the dev team the tools they need to solve this problem?