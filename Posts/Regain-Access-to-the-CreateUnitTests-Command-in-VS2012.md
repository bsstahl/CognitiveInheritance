---
tags:
- visual studio
- unit testing
- tdd
menuorder: 0
id: c34168ee-706f-4c7d-9665-ffd986b6f1b6
author: bsstahl
title: Regain Access to the CreateUnitTests Command in VS2012
description: 
ispublished: true
showinlist: false
publicationdate: 2012-12-27T15:16:00.000+00:00
lastmodificationdate: 2012-12-27T15:16:00.000+00:00
slug: Regain-Access-to-the-CreateUnitTests-Command-in-VS2012
categories:
- Development

---
I previously expressed my annoyance [here]({PathToRoot}/Posts/The-Missing-e2809cCreate-Unit-Teste2809d-feature-in-Visual-Studio-2012.html) and [here (starting at 01:02:06)](http://channel9.msdn.com/Events/Build/2012/3-017) about the lack of the Create Unit Tests feature in Visual Studio 2012, similar to the one in Visual Studio 2010.  It is interesting that none of the Microsoft people I’ve spoken to on the issue were able to provide me with a reasonable work-around, but apparently, [intrueder](http://stackoverflow.com/users/1741116/intrueder), a commenter at [Stack Overflow](http://stackoverflow.com/questions/9547055/where-is-the-create-unit-tests-selection), has.  It turns out that the functionality was not removed from the Visual Studio product, just from the context menu. Therefore, we can give ourselves access to the command again by assigning a keyboard shortcut to it.  The steps to do so are as follows:

1. In Visual Studio 2012, select **Options** from the **Tools** menu on the top menu bar.
2. In the **Environment** section of the dialog, select **Keyboard**.  This will show you a list of commands and their keyboard shortcuts if they have one.
3. In the **Show commands containing** box, type **CreateUnitTests**.  You should see the command window filter down to the **EditorContextmenus.CodeWindow.CreateUnitTests** command, which will be highlighted.
4. If there is anything shown in the **Shortcuts for selected command** drop-down, you are already done.  You can use whatever key sequence is listed to access the command as described below.
5. If there is nothing shown, you’ll need to assign a keyboard shortcut.  Press the key sequence you’d like to use while in the **Press shortcut keys** text box.  If that shortcut is already assigned, the **Shortcut currently used by** drop-down will change to show how the key sequence is currently used.  You may have to try several key combinations before you find one that you are comfortable using, especially if you use a product like Resharper which maps a bunch of additional shortcuts on top of the Visual Studio default key mappings.
6. Once you decide on a key sequence and those keys (or key) appear in the **Press shortcut keys** text box, press the **Assign** button to map the sequence to the command.  You can now use that key sequence to access the CreateUnitTests command as described below.

Now that a shortcut is setup, all you have to do is place the cursor within the scope that you want to create unit tests for (a namespace, class or method) and invoke the key sequence.  The command should be activated as it was in Visual Studio 2010.  I have been using this for a little while and it is working quite well for me, but I don’t make use of nearly all of the features of this command.  I’ll be interested to hear if you have any troubles using this tool in this way. You can contact me on Twitter at [@bsstahl](https://twitter.com/bsstahl) if you have any comments.