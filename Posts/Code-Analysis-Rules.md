---
tags:
- code analysis
- assembly
- entity framework
- fxcop
- logging
- strong name
- visual studio
menuorder: 0
id: dde02ea3-ba8e-4066-8dc6-9cb9dbadc450
author: bsstahl
title: Code Analysis Rules
description: 
ispublished: true
showinlist: false
publicationdate: 2011-06-07T08:46:42.000+00:00
lastmodificationdate: 2011-06-07T08:46:42.000+00:00
slug: Code-Analysis-Rules
categories:
- Development

---
FxCop, the built-in code-analysis tool in Visual Studio, is the first thing I check when doing a code review.  If Code Analysis is enabled for a project, setup properly, and its rules have not been overridden, this tool will help maintain consistency in the code, even if that code is worked on by multiple developers.  FxCop also does a good job of identifying if some common mistakes have been made, such as not disposing of an IDisposable object, and can identify things that will help the compiler do its job better, such as ensuring that assemblies which expose public objects identify whether or not they are intended to be CLS compliant.

In order to get these benefits, code analysis must be enabled for each project and a rule set must be selected.  Because adding code-analysis to existing assemblies can be a bit painful, it is recommended that you enable this analysis as soon as a project is created in Visual Studio.  To enable code analysis for an assembly, select the project properties, go to the Code Analysis tab, and check the “Enable Code Analysis on Build (defines CODE\_ANALYSIS constant)” box.

![Visual Studio Dialog]({PathToRoot}/Images/image_2.png)

The default rule set that will be run during code analysis is called “Microsoft Minimum Recommended Rules”.  This is a very small set of rules that is a good one to enable if you are starting to do code analysis on a previously coded assembly.  If however, you are starting clean, I highly recommend starting with either the “Microsoft All Rules” rule set, or your own version of that set, since this rule set will provide the most benefit in all areas of analysis.  To create your own rule sets, select the set you wish to modify and press the “Open” button next to the rule set drop-down.  Once opened, you can make any changes you wish, and use the File –&gt; Save-as menu item to save the rule set with a different file name.  New rule sets will automatically appear in the drop-down menu. You can use the properties tab to update the Name and Description of the set, and the rules editor to enable or disable individual rules.  You can also define, for each rule, whether failures are ignored, result in a warning, or generate a compilation error.  I highly recommend setting all rules that you want to enforce to cause errors since they can always be overridden if necessary but will likely be missed if they only result in warnings.

![Rules List]({PathToRoot}/Images/image_3.png)

For my projects, I use one of several rule sets that I have set up, all of which are slight modifications to the “Microsoft All Rules” rule set.  I will detail the rule set changes I make and overrides that I allow in each set of circumstances below.  I encourage you to experiment with these rule sets to determine the optimum configuration for your projects.

# 

### All Projects

- Modify the “Microsoft All Rules” rule set so that all rules result in an error.  The easiest way to do this is to use the “group by” drop-down to order all rules by “Target Type”.  The only type found here should be “Managed Code”.  With this single group collapsed, use the Action drop-down to select “Error” for all rules.


### Entity Framework Projects

- The Entity Framework requires navigation properties of entities to be read-write, a violation of rule CA2227, “Collection properties should be read only”.  For projects utilizing the Entity Framework, as well as those designed for use within the entity framework (such as entity POCO libraries), the action of this rule may be set to “Warning” to prevent compilation errors whenever entities with navigation properties are built.


### Projects Deployed to Internal Company Servers (and not GAC’ed)

- Assemblies that will not be deployed to the GAC and will remain on secure, internal servers do not need to have a strong name. Thus, rule CA2210, “Assemblies should have valid strong names”, can be permanently over-ridden or have its action set to “None”.


### Non-Localized Projects

- For projects that are never to be localized to a foreign culture, you can set the action for rule CA1303, “Do not pass literals as localized parameters”, back to “Warning”.  I find this rule to be especially incorrect when I am writing logging code within my methods (unless using aspect-orientation) because the logging code also serves as functional code-comments if the literals are included in the method calls.


### Console Applications

- Many console apps ignore the command-line parameters passed-in to the main method, a violation of rule CA1801, “Review Unused Parameters”.  Most of the time, this rule is valuable since you don’t want to have parameters to methods that are never used, however, since we cannot change the parameters to the main method of a console app, but may not wish to use them, this rule can be set to generate a warning in console applications, or can be simply overridden for the parameters to the main method of each console app.  This rule may also be violated temporarily when a method has been stubbed but not yet implemented.  In that case, the rule should be overridden in code similar to rule CA1822 below.


### Other (More Temporary) Modifications

- Rule CA1822, “Mark members as static”, is violated when a method in a class does not use any of the other non-static members of the class.  This is always true when the method has not yet been implemented (is only a stub).  Prior to the method being implemented, this rule should be overridden in code.  The override should be removed from the code once the method has been implemented.
- Rule CA1040, “Avoid empty interfaces” is often violated temporarily in TDD/BDD because interfaces may be created without methods and then be built-up as needed by the use-case.  Prior to the interface being defined, this rule should be overridden in code.  The override should be removed from the code once the interface has been defined.


I have found using Code Analysis to be a good way to improve the maintainability of my applications, especially when the app is being worked on by multiple members of a project team.  The FxCop tool, built into Visual Studio’s Ultimate and Premium editions, is one of a number of tools and techniques I use to keep my code as maintainable and extensible as possible, resulting in the lowest possible total cost of ownership (TCO).  In future articles, I will explore additional tools and techniques I use for this purpose.