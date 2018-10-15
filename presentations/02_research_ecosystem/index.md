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

First I'll briefly explain:
* IDEs
* Version control (git)
* Github
* Literate programming
* Open Science Framework

Then we'll practice using them.

---  &twocol

## IDEs

*** =left
__IDEs are Integrated Development Environments__ - they let you do development in one place. 

We're using ![R Studio](https://www.rstudio.com/) today, but I really rate [Sublime Text](https://www.sublimetext.com/).

*** =right
__IDEs usually have:__
* Editor
* Compiler or interpreter
* Debugger
* Sometimes extra stuff

---&twocol
## Version Control with Git and GitHub

*** =left
__Git__ is a version control system that's used by ~70% of developers across all programming languages.

__GitHub__ is a platform to which hosts code for collaboration.

*** =right
They help you avoid this sort of thing and they also help you keep track of the changes that you've been making to your code and help you collaborate with others:
<div class="rimage center"><img src="fig/final_version.jpg" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="50%" class="plot" /></div>
---

## Git Glossary

__repository__: A repository represents a project - it's a directory where changes will be tracked. A repository is where your project is stored.
__branches__: Branches are different (parallel) versions of the repository. You should make a new branch for each different feature in your code.
__clone__: A clone is a local copy of the repository which you can make changes to and later be synced into the "remote" (online) version.

---&twocol

## GitHub "Tour"

*** =left
Let's check out the GitHub website where we have [the repository](https://github.com/RobertArbon/analysis_best_practice) that me and Rob used to collaborate on this workshop. 

*** =right
Things to note:
* The README.md
* How to navigate
* How to clone an existing repository
* How to make a new repository

--- 

## Clone the 'analysis_best_practice' repository.
* Go to [https://github.com/RobertArbon/analysis_best_practice]
* Open RStudio (a new window)
* File>New Project...>Version Control>Git


---
## Markdown

Markdown is a intuitive language which can easily be converted to html. It's a really simple way to style text on for websites.

```markdown
It's very easy to make some words **bold** and other words *italic* with Markdown. 

It's also very easy to  [link to Google!](http://google.com).

It's also how this presentation was formatted!

```
GitHub likes Markdown. It will:
* automatically render READMEs written in Markdown
* render commit and pull request messages written in Markdown.

---

## GitHub "Hello World"


---
## The Git Parable
A condensed excerpt from [the Git Parable]()
---
## GitHub
---
## Markdown 
---
## GitHub Excercise
---
## Making RStudio play with GitHub
---
## Literate programming
---
## RNotebooks
---
## Open Science Framework
---
The ![Open Science Framework](https://osf.io/dashboard) is a 

