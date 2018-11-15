---
title: "Integrated Development Environment (IDE)"
subtitle: "Data analysis best practice"
author: "Robert Arbon"
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



## IDEs

* Goal: **Make coding/data analysis easier**
* Content:
  * Text editor with syntax highlighting
  * Compiler or interpreter
  * Debugger
  * Lots of other *little* things easier, e.g. version control, file manager, console, terminal, autocomplete...

---

## IDE examples

* For `R` there is [R Studio](https://www.rstudio.com/) 
* For `Python` there is [PyCharm](https://www.jetbrains.com/pycharm/)
* For general purpose there is [Sublime Text](https://www.sublimetext.com/). There are lots of others!
* For datascience type applications, the [Jupyter](http://jupyter.org/) project is powerful. 

---&twocol

## RStudio - projects

*** =left
* `.RData` - a snapshot of your workspace
* `.RHistory` - a history of commands you ran in text
* `MyProject.RProj` - project level settings for RStudio
* File templates: R scripts, RMarkdown, plain text, C++, R Presentation...
* `Console`: Run R commands from a terminal
* `Terminal`: run bash commands from a terminal

*** =right
* `Environment`: view all objects in various environments
* `History`: list of previously run commands
* `Git`: manage your version control
* `Files`: view and manage your files. 
* `Plots/Viewer`: view plots and other output (e.g. html documents)
* `Packages`: manage packages

---&twocol

## Writing code

*** =left

* LOTS of commands to make writing code easier in `Code` menu
* **Most useful** is `tab` complete: 

<div class="rimage center"><img src="fig/tabcomplete.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="100%" class="plot" /></div>

* Debugger is also very useful


*** =right


<div class="rimage center"><img src="fig/code.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="50%" class="plot" /></div>

---&twocol

## Customize RStudio

*** =left

<div class="rimage center"><img src="fig/global.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="100%" class="plot" /></div>

*** =right

<div class="rimage center"><img src="fig/project.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="100%" class="plot" /></div>

---

## Exercises

1. Configure your RStudio with the following layout: 
  1. Bottom left: `Console` and `Terminal`
  2. Top left: `Source`
  3. Top right: `Environment`, `History`, `VCS`
  4. Bottom right: `Files`, `Plots`, `Packages`, `Help`, `Viewer`

2. Check the 'Options'> 'RMarkdown': What directory are code chunks evaluted in?  Can you change this? What does this mean?

3. Look in the 'History' pane - try and run a previous command in the console without typing it out. 
