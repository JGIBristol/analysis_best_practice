---
title: "Version Control"
subtitle: "Data analysis best practice"
author: "Natalie Thurlby"
highlighter: highlight.js
hitheme: tomorrow
job: Data scientist, Jean Golding Institute
# logo: jgi-logo.jpg
mode: selfcontained
framework: io2012
url:
  assets: ../assets
  lib: ../libraries
widgets: mathjax
---





---&twocol
## Version Control

*** =left
Version control helps you to keep track of different versions of the same file. 

Version control was developed for programming, but it works well on anything text-based. It helps you to get back to old versions of files if you don't like a change you made. It also helps you to create a log of what changes you are creating and why.

*** =right
It also helps you avoid this sort of thing:
<div class="rimage center"><img src="fig/final_version.jpg" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="60%" class="plot" /></div>

---&twocol
## Git and GitHub

__Git__ is the most popular version control system: it's used by ~70% of developers across all programming languages.

__GitHub__ is a platform to which hosts code for collaboration. It's also a good way to store the work you are doing so that you are backed up in an extra place. You can link GitHub projects with the Open Science Framework.

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

## The git/github workflow

*** =left

* <font size = 3>The __master__ branch should always be in good working order.</font>
* <font size = 3>If you want to add new functionality/work on the code, create and move to (__checkout__) a development __branch__.</font>
* <font size = 3>When you make changes to a local branch that you are happy with, you can decide to take a snapshot of your files (a __commit__) and label them with a message about the changes. To __commit__ you must first decide which files you wish you commit to changing - known as adding the files to to a __staging__ area. Then you __push__ your committed changes from your local copy of the repository to the remote (online) version.</font>
* <font size = 3>After many commits, when you have finished the new functionality for the branch, you can __merge__ it into the master branch/trunk of the tree (via GitHub) by creating a __pull_request__.</font>

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
* The instructions for the rest of the exercise in "exercises/version_control.Rmd"
