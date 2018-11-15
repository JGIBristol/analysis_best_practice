---
title: "Reproducible Research"
subtitle: "Data Analysis Best Practice"
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


```
## Error in library(tidyverse): there is no package called 'tidyverse'
```

```
## Error in library(FSA): there is no package called 'FSA'
```

## What is reproducibility?

These are the terms which most people seem to be using:

__Reproducible:__ Your research is reproducible if other people get the same results running the same analysis on your data.

__Replicabile:__ Your research replicates if other people repeat the experiment and their results are consistent with yours. 

___________

Being reproducible is a prerequisite for being replicable; __at a minimum your work should be reproducible__. 

Today we're going to try and __reproduce__ the results of a paper.

Good practices in data analysis will help you with both reproducibility and replicability (plus other benefits)!

---

## Reproducibility crisis

__Less than 40%__ of replications of well-known Psychology studies had significant results:

<div class="rimage center"><img src="fig/psychology-replication-paper.jpg" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="100%" class="plot" /></div>
"Open Science Collaboration. "Estimating the reproducibility of psychological science." Science 349.6251 (2015): aac4716.

Only __11%__ of replications of well-known cancer biology studies had significant results. 

Begley, C. Glenn, and Lee M. Ellis. "Drug development: Raise standards for preclinical cancer research." Nature 483.7391 (2012): 531.

--- &twocol

## Most researchers think there is a problem with reproducibility

*** =left

<div class="rimage center"><img src="fig/is-there-a-crisis.jpg" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="100%" class="plot" /></div>

*** =right

Baker, Monya. "1,500 scientists lift the lid on reproducibility." Nature News 533.7604 (2016): 452


---&twocol

## Most researchers have failed to reproduce a result
*** =left

<div class="rimage center"><img src="fig/failed-to-reproduce.jpg" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="100%" class="plot" /></div>

*** =right

Of the 1576 scientists surveyed, __over 70% of scientists surveyed have experienced failure to reproduce other's results__ and __over 50% have failed to reproduce their own results__.

---

## Why should we be reproducible?

* It's the right thing to do - it gives us all better science.
* Helps you to avoid disaster/embarrassment.
* Saves you time in the long run
    * Helps you to write papers/your thesis.
    * Helps you continue your research by remembering what you did, so you or someone else can build on your previous work.
* Makes you a better researcher (because you know people can check your work, you will too)
* Good for your reputation (makes you more trustworthy). 

---

## Types of reproducibility problems

* Lacking information: data or methods not provided in full.
* Data Storage problems
* Analysis environment
* P-hacking (and HARKing)

--- &twocol
## Provide your methods and data!

*** =left
In order for your work to be reproducible, at minimum, you must provide enough information for another researcher to be able to reproduce it.

This requires you to __make your data and methods available!__

And __make what you provide usable to others__ by making sure that you store your data (with documentation) publicly wherever possible and provide a full description of your methodology as well as a script that others can run to check your results.

*** =right
If you don't then, great, but if sharing your code sounds scary:
* You could run your scripts through a linter ([lintr](https://cran.r-project.org/web/packages/lintr/index.html) in R - supported in RStudio) first to have it tell you about any errors that can be automatially detected.
* Everyone can improve at this stuff, so I think everyone finds it a bit scary. Share your stuff anyway, please!

<div class="rimage center"><img src="fig/imposter.jpg" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="100%" class="plot" /></div>

---&twocol

## Data Storage 

*** =left
__Avoid:__
- Accidentally editing data or results
- Forgetting version or origin of data
- Making it hard or impossible for your data to be accessed and understood by others/your future self.

__Avoid because:__
- Overwriting data will affect your results. 
- No one will be able to reproduce your results (including you), even if they are right.

*** =right
__Suboptimal file names:__
* "data.csv""
* "mice friendliness.txt"
* "deprivation_final_actually_for_realsies.txt"
* "bees_measurements.xls"

<div class="rimage center"><img src="fig/duke-scandal.jpg" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" width="80%" class="plot" /></div>

---&twocol

## Data Storage 

*** =left

__Anxiety-inducing:__
<div class="rimage center"><img src="fig/directory_bad.jpg" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" width="90%" class="plot" /></div>

*** =right
__Pretty good:__
<div class="rimage center"><img src="fig/directory_good.jpg" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" width="90%" class="plot" /></div>

* Organise files sensibly. 
* Make data folders read only. 
* Name files well. 
* Include all information you need to re-collect the data in a readme file.
* Store data in text format where possible (easy to share and to version control)

---&twocol

## Analysis environment - Scripts

*** =left
__Avoid:__
- Clicking through a GUI to run analysis.
- Using proprietry software.
- Writing scripts that no one can understand.
- Forgetting what your scripts do.

__Avoid because:__
- Will take you ages to repeat analysis if you need to.
- The order of doing things could change the results (results might be wrong).
- Other people will not be able to reproduce your work.

*** =right

__Solve by:__
- Writing scripts
- Writing scripts in non-proprietry software (i.e. R and python beat STATA and SPSS)
- Writing scripts that are easy to understand: comment your code or embed it in "notebooks" (eg. [Jupyter](http://jupyter.org/) or [R notebooks](https://rmarkdown.rstudio.com/r_notebooks) and name your variables sensibly. 
- Documenting your scripts (README files, comments, documented functions)

---&twocol

## Analysis environment - Version Control

*** =left
__Avoid:__
- Saving over earlier work without being able to get back to it 
- Having files named "analysis_version32_final_actually_final.R"

__Avoid because:__
- Nothing is worse than knowing your program worked a minute ago.
- You won't be able to remember which is the actually_actually_real_final_file.txt

*** =right
<div class="rimage center"><img src="fig/final_version.jpg" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" width="50%" class="plot" /></div>

__Solve by:__
- <font color='red'>Using version control (i.e. Git)</font>

---&twocol
## P-values

*** =left

__What does it mean if p < 0.05?__
> - Your result is true?
> - Your result is interesting? 
> - Your result will be easier to publish?
> - There is a 1 in 20 chance that your result is a false positive (assuming that you're using the right measure and all your assumptions are correct).

> - To put this another way: if your hypothesis is completely wrong (it has no effect on your measure), then assuming you are doing your statistics correctly, one in 20 times you will randomly get a false positive (p<0.05).

*** =right
<div class="rimage center"><img src="fig/dice.jpg" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" width="80%" class="plot" /></div>

---

## Experiments - Simulation 1

Imagine that you are a researcher, you have your own dataset and you are going to test one scientific hypothesis. The hypothesis you have chosen is __not true__, but of course you don't know that yet!

We are going to simulate this situation by rolling a 20-sided dice!
* Rolling a 1 is equivalent to p<0.05 (a false positive)
* Rolling anything else => p>0.05 (a true negative)

Instructions:
> - Roll a 20-sided dice once each.
> - How many of you rolled a 1? (Got a false positive)
> - For one of you, what do you think the probability is of you rolling a 1 (getting a false positive)?

---&twocol

## Experiments - Simulation 2

You are still a researcher with your own dataset, but now you are going to test 10 slightly different variations on your scientific hypotheses on your dataset. All of these hypothesis are still __not true__, but again, you don't know that!

*** =left

Instructions:
> - Roll a 20-sided dice 10 times each. 
> - How many of you rolled at least one "1"? (Got a false positive)
> - How many of you rolled more than one "1"?
> - What do you think the probability is of rolling at least one 1 (getting a false positive) if you test 10 hypotheses?

*** =right
<div class="rimage center"><img src="fig/forking_paths.jpg" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" width="100%" class="plot" /></div>

--- &twocol

## HARKing

*** =left
__HARKing = Hypothesising After Results are Known__

Instead of trying the same hypothesis with 20 different methodologies, you can get the same effect (finding erroneous "significant" results) by testing 20 different hypotheses and decide what you hypothesised afterwards.

*** =right

<div class="rimage center"><img src="fig/jellybean_xkcd.jpg" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" width="45%" class="plot" /></div>

---

## HARKing example

<div class="rimage center"><img src="fig/HARKing_real.jpg" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" width="100%" class="plot" /></div>

__Bold__ = abstract presented

Text = full description of experiment

---&twocol

## P-hacking

P-hacking is a catch-all term for making p-values appear smaller than they are. 

*** =left
__Examples of p-hacking:__
- HARKing
- Collecting samples until your sample size gives you p < 0.05
- Choosing a different test to get p<0.05

__Solutions to p-hacking:__
* Pre-registration and [Registered reports](https://cos.io/rr/) (saying what you analysis you will do in advance: more on this later)
* Multi-hypothesis corrections (e.g. [Bonferroni correction](https://en.wikipedia.org/wiki/Bonferroni_correction))
* Simulating data.

*** =right
<div class="rimage center"><img src="fig/p_values_xkcd.jpg" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" width="40%" class="plot" /></div>
<div class="rimage center"><img src="fig/p-curve.jpg" title="plot of chunk unnamed-chunk-14" alt="plot of chunk unnamed-chunk-14" width="50%" class="plot" /></div>


---&twocol

## Summary 

*** =left
__Reproducible research is important because:__.
* It saves your time when you come back to your work.
* Its good for your reputation (by avoiding disaster, improving your motivation to do good work, and through open science badges, etc).
* It saves us from bad science.

*** =right
__Main causes of poor reproducibility:__
* (1) Poor data storage
* (2) Poor analysis pipeline
* (3) Lack of sharing data/methods
* (4) Poor use of p-values

(1)-(3) are just a matter of becoming familiar with the tools we're going to be using today. If you have any more questions about (4), you can email us <ask-jgi@bristol.ac.uk>

---&twocol


## Take home message:

If you don't do anything else, these three things will massively improve the reproducibility of your work:
* <font size = 20>Write some scripts</font>
* <font size = 20>Share your data and code</font>
* <font size = 20>Use version control</font> 
