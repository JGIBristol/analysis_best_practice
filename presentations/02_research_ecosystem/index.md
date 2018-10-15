---
title: "Data analysis best practice"
subtitle: "Research Ecosystem"
author: "Natalie Thurlby"
highlighter: highlight.js
hitheme: tomorrow
job: Data scientist, Jean Golding Institute
# logo: jgi-logo.jpg
mode: selfcontained
framework: io2012
url:
  assets: ../assets
  lib: ../librariesNew
widgets: mathjax
---



## Overview

Most of this session will be spent on using version control with GitHub in RStudio:
* IDEs (RStudio)
* Version control (git) and GitHub 
There will also be a brief introduction to:
* Literate programming (RNotebooks and Jupyter Notebooks)
* The OSF (Open Science Framework)

---  &twocol

## IDEs

__Open a new RStudio window__ 
Make sure you have the Console, Files, and Source windows visible.

*** =left
__IDEs are Integrated Development Environments__ - they let you do development in one place. 

We're using [R Studio](https://www.rstudio.com/) today, but I personally rate [Sublime Text](https://www.sublimetext.com/) as my favourite IDE for lots of different languages (especially Python).There are lots of others!

*** =right
__IDEs usually have:__
* Editor
* Compiler or interpreter
* Debugger
* Sometimes extra stuff (auto-completion, console, terminal, file viewer, built-in version control...)

---&twocol
## Version Control with Git and GitHub

*** =left
__Git__ is a version control system that's used by ~70% of developers across all programming languages.

__GitHub__ is a platform to which hosts code for collaboration.

*** =right
They help you avoid this sort of thing:
<div class="rimage center"><img src="fig/final_version.jpg" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="60%" class="plot" /></div>
They also help you keep track of the changes that you've been making to your code and help you collaborate with others.

---&twocol

## Git Glossary

*** =left
__repository__: A repository represents a project - it's a directory where changes will be tracked. A repository is where your project is stored.

__branches__: Branches are different (parallel) versions of the repository. You should make a new branch for each different feature in your code.

__fork__: A fork is your own private version of the repository (stored on GitHub) which you can make changes to without affecting the original version.

__commit__: A commit is a snapshot of your files at a particular time.

*** =right
<div class="rimage center"><img src="fig/git-tree.jpg" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="65%" class="plot" /></div>

---&twocol

## The basics of the git/github workflow

*** =left

* <font size = 3>The __master__ branch should always be in good working order.</font>
* <font size = 3>If you want to add new functionality/work on the code, create and move to (__checkout__) a development __branch__.</font>
* <font size = 3>When you make changes to a local branch that you are happy with, you can decide to take a snapshot of your files (a __commit__) and label them with a message about the changes. To __commit__ you must first decide which files you wish you commit to changing - known as adding the files to to a __staging__ area. Then you __push__ your committed changes from your local copy of the repository to the remote (online) version.</font>
* <font size = 3>After many commits, when you have finished the new functionality for the branch, you can __merge__ it into the master branch/trunk of the tree using (via GitHub) by creating a __pull_request__.</font>

*** =right
<div class="rimage center"><img src="fig/git-tree.jpg" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="65%" class="plot" /></div>
<div class="rimage center"><img src="fig/git_basic.jpg" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="60%" class="plot" /></div>

---&twocol

## GitHub "Tour"

*** =left
Let's check out the GitHub website where we have [the repository](https://github.com/RobertArbon/analysis_best_practice) that me and Rob used to collaborate on this workshop. Here you can find all the information for this workshop! 

*** =right
Things to note:
* The README.md
* How to navigate
* How to fork and clone an existing repository
* How to make a new repository

GitHub likes Markdown. It will:
* automatically render READMEs written in Markdown
* render commit and pull request messages written in Markdown.

--- 

## Getting started 
### Forking the repository and finding the rest of the instructions.
* Go to [https://github.com/RobertArbon/analysis_best_practice]. Login and fork the repository.
* The instructions are in "exercises/version_control.Rmd"

<!-- ### Making a new remote branch -->
<!-- * Now go to the forked copy of the repository [https://github.com/YOURUSERNAME/analysis_best_practice]. -->
<!-- * On GitHub, create a new branch called 'workshop-practice' in your fork of the repository. -->
<!-- * Create a new first.md file inside 'workshop-practice' and edit it (from GitHub). -->

<!-- ### Cloning the forked repository -->
<!-- * Open a new RStudio window -->
<!-- * File>New Project...>Version Control>Git -->
<!-- * Enter the git@github.com:YOURUSERNAME/analysis_best_practice.git (which you can find on your forked github repository where the green clone button is) and choose where to store this information. RStudio will always clone the master branch. -->

<!-- ### Working on your local copy of the repository - creating a new local branch: -->
<!-- * Look inside the files area in RStudio (notice that your first.md file is not yet there) -->
<!-- * Choose the new workshop-practice branch from the Git window inside RStudio (on the right hand side it should say master with a down arrow). This creates a new (local) copy of the workshop-practice branch which "tracks" the online version of that branch (allows you to push changes to it and pull changes from it).  -->
<!-- Congratulations, you're set up on the repo and ready to start making changes! -->

<!-- ### Your first commit! -->
<!-- * Notice that the new first.md file has appeared in your directory. -->
<!-- * On this occasion you are the only one using the repository, so there won't be any remote changes to __pull__ (there won't be any changes online that aren't in your local copy), but it's a really important habit to remember to pull before making any new changes. In Rstudio, you can pull from the tracked branch by clicking the blue down arrow in the git tab. -->
<!-- * Open the first.md file in RStudio. -->
<!-- * Make some changes to it and save it (try adding some lines and deleting others) -->
<!-- * In RStudio, go to Tools>Version Control>Diff (or click Diff in the Git window), you will be able to see the __diff__erences between the local version of the file and the remote version, i.e. you'll be able to see the changes you have made (green lines have been added, red lines deleted). -->
<!-- * Look inside the Git window inside RStudio. There will be an unchecked box next to the file and it's status will be 'M' for modified.  -->
<!-- * Tick the 'Staged' checkbox, when you want to __add__ or __stage__ your changes.  -->
<!-- * When you are ready, you can __commit__ these staged changes by clicking 'Commit'. This will require you to write a descriptive message about the changes you have made. You can use markdown (including the same emojis from HackMD for these commit messages) -->
<!-- * You can then __push__ your changes to your forked copy of the repository (the green upwards arrow in the Git window of Rstudio). -->
<!-- * Go to GitHub and check that you see your changes there. -->

<!-- ### Pull from the repository -->
<!-- * To simulate working with someone else, go to GitHub and create a new file called 'second.md'. -->
<!-- * Go back to RStudio and notice that you do not yet have a copy of this file. -->
<!-- * Pull the change from the repository to RStudio. -->

<!-- ### Your first pull request. -->
<!-- Think about a pull request in terms of you are requesting that the remote (online) repository pulls your changes. -->
<!-- * Create a new local file inside your repository 'third.md' and make some changes to it. Notice how this shows up in the git window. These orange question marks mean the file is untracked.  -->
<!-- * Go through the cycle of pulling changes from the remote repository, changing your three .md files, staging their changes, committing and pushing those changes a few more times until you feel you have the hang of it. -->
<!-- * Once you're happy, go back to your GitHub page, go to the forked repository, go to the Pull requests tab and click "New pull request". -->
<!-- * Choose the workshop-practice branch to request to merge it back into the master branch. You can make some comments in the pull request about why you are requesting to be merged back in. -->
<!-- * You can then choose to review and accept the pull request by clicking the 'merge pull request' button, you may also leave some comments about how you feel about (emojis encouraged, :rage5: or :100:?) -->

<!-- ### Take this opportunity to investigate the history/tree of your repository -->
<!-- * In RStudio, go to Tools>Version Control>History (or click the clock face in the git window) -->
<!-- * Invetigate your repository from GitHub, look at your commit logs, etc. -->

<!-- ### When you are finished with your development branch, you can delete it: -->
<!-- * Go to GitHub>Your forked repository>branches and click on the bin icon next to the branch you want to delete. -->

<!-- ### Create a new branch for a new feature -->
<!-- * Do this in the same way as before, by making a new branch in GitHub, then pulling in RStudio to get the new branch information, then changing to the new branch in RStudio (this will only work if your current branch is up to date). -->

<!-- ### The Git Parable: -->
<!-- If you have time you can read this fun metaphor/story about Git: [the Git Parable](http://tom.preston-werner.com/2009/05/19/the-git-parable.html) -->

---&twocol

## Literate Programming - R Notebooks and Jupyter notebooks
Literate programming is the idea of interleaving easy to read information about what the code is doing with the code. Can embed visualisations, apps, interactive graphs, 3D models, etc.

*** =left
__RMarkdown Notebooks__:
* Only available for R
* Allows you to insert interactive snippets of R code into a markdown document.
* Can publish on [https://rpubs.com/]

*** =right
__Jupyter__:
Developed for Python (IPython Notebooks), but now works for many different languages, including R.
* Interweave interactive cells of markdown, and code (in different flavours) in order to communicate your findings and methods as well as possible. 
* Can publish on [nbviewer](http://nbviewer.jupyter.org/)

---&twocol

## Open Science Framework "Tour"

*** =left

The [Open Science Framework](https://osf.io/dashboard) is a free web app for sharing scientific research. 

Researchers use OSF to collaborate, document, archive, share, and register research projects, materials, and data. 

*** =right
Things to note:
* Read preprints
* Create/collborate on projects
* Register methods reports

