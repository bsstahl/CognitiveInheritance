---
tags:
- ci_cd
- git
- azure
- devops
- azure devops
categories:
- Tools
menuorder: 
id: ee2bd796-a0f2-4536-af7d-3c1499c093b6
author: bsstahl
title: Committing to Git from an Azure DevOps Pipeline
description: ''
ispublished: true
showinlist: false
publicationdate: 2020-06-17T16:55:00.000+00:00
lastmodificationdate: 2022-07-13T14:22:00.000+00:00
slug: Committing-to-Git-from-Azure-DevOps-Pipeline

---
There are occasions, such as when working with static website generators, that you'll want to push some changes made in an Azure DevOps pipeline, back into the source Git repository. This process is simple enough, but since I have struggled to get it configured twice now, I am documenting the process here for your use, and my future use.

Azure DevOps pipelines typically contain two parts, although other configurations are possible. The two standards are:

* Get sources - gets the information to work with from a Git repository or other source control environment
* Agent Job - holds the tasks required to complete the pipeline

You'll need to take the following steps to configure the interactions between your source control provider and your pipeline:

* Configure the **Get sources** section of the pipeline by selecting your source control provider from the list of options and then choosing the repository from the list within that provider. For most providers, you will need to supply credentials with access to the repository, although the pipeline may already have the basic access it needs to read from an Azure DevOps Repo.

![Azure DevOps Sources](/Images/azure_devops_sources.PNG)

* \[optional\] Configure an **Agent Job** to perform any cleanup of the repo necessary. When building a static website, I first delete all files from the target directory (the old static website files) so that only the files that are still needed are included in the final deployment.

> Note: for all Agent Job steps that involve scripting, I use the **Command Line** task which allows me to execute my scripts in one of the native OS shells (Bash on Linux and macOS and cmd.exe on Windows). You could just as easily use the **Powershell** task, which is cross-platform or any number of other options.

* Execute your build process. This is the step that generates the new files that will eventually be committed back into the source repository. Each static website generator has their own method for creating the site, see the documentation for your tooling for specifics. You can also execute custom tools or scripts here that modify files in the repository any way you'd like.

* Execute the commit back to the source repo. This is the money step, where everything that has been done to this point is saved in the repository. As with previous steps, I use the **Command Line** task to execute the needed commands. My script is shown below. It is written for the Windows **cmd.exe** shell so commands that start with _ECHO_ are log entries that will be included in the pipeline's execution log to help with troubleshooting and maintenance. This script uses a number of **pipeline variables** which take the form _$(variableName)_ to make configuration easier. The _git.email_ and _git.user_ variables were defined by me in the _Variables_ section of the pipeline, you will need to either configure those variables yourself, or substitute their values in the script. The _Build.SourceVersion_ and _Build.SourceVersionMessage_ variables are supplied by the pipeline and no action was required on my part to create or enable them.

An interesting thing to note about this script is the _git push_ command. The full command `git push origin HEAD:master` is required in this case, rather than just a simple `git push` because, once the files are downloaded into the pipeline repo, the local repository is disconnected from the remote by the pipeline, possibly as a safety measure. We have to tell the local repo to push back to the remote HEAD, or else the push will fail. I suspect there is a way to tell the pipeline not to disconnect the head, but doing things this way, to my knowledge, has no ill-effects and is simple enough that it isn't really worth the effort for me to find out.

    ECHO ** Starting "Git config for user: $(git.user)"
    git config --global user.email "$(git.email)"
    git config --global user.name "$(git.user)"
    
    ECHO ** Starting "Git add..."
    git add .
    
    ECHO ** Starting "Git commit..."
    git commit -m "Static site rebuild due to commit $(Build.SourceVersion) '$(Build.SourceVersionMessage)'"
    
    ECHO ** Starting "Git push..."
    git push origin HEAD:master
    
    ECHO ** Ending Update remote git repo script

* Finally, we need to give the pipeline user permission to write to the repository. This is where things can get a bit tricky and hard to find. The key configuration area within Azure DevOps can be found by going to the _Project Settings_.

  * For Azure DevOps repositories, select the _Repositories_ tab and click on the _\[Projectname\] Build Service User_ in the _Users_ section. This will show a list of permissions that the build service user has. There are 4 that are of interest here: _Contribute_, _Create branch_, _Create tag_ and _Read_. Some of those will probably already be enabled for you. I suspect only the _Contribute_ needs to be added at this time, but I usually make sure all 4 are allowed.
  
  * For other repositories, things are even more complicated. Accounts need to be configured on the external source control service so that the Build Service User account has the permissions it needs to push to that repository. This may require an SSH configuration, an Auth token, or any number of other mechanisms depending on the source control provider. See that provider's documentation for the specifics.

> Update 2022-07-13: There is an additional option that needs to be enabled in the pipeline's _Agent Job_.
> `☑ Allow scripts to access the OAuth token`
> This option must be checked so that the script can acquire the permissions to update the repository.

There are other ways to do all of this of course. One idea that intrigues me that I haven't tried yet is to have the build service submit a pull-request to the remote git repo. This would require an additional approval step before the changes are merged into the repo. For static websites where merging into master is the equivalent of publishing the site, this might give me the opportunity to review the built site before it is actually deployed.

Have you tried this pull-request method, or used this kind of technique with an non-Azure DevOps repo? If so, please let me know about it on Twitter {TwitterLink}.
