---
title: "Tidy data"
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




## Tidy data

* Most data sets need **cleaning** before they can be used. 
* **Cleaning** involves:
  * Getting data into tables
  * Getting formats correct e.g., dates and times, units of measurement
  * Grouping observations together in meaningful ways
  * Tidying data: structuring datasets to facilitate analysis
* **Tidy data** is a set of standards for organizig data values within a dataset.

---

## Tidy data
<div class="rimage center"><img src="fig/tidydata.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="100%" class="plot" /></div>



---

## Tidy data  - Semantics

* **Values**: entries in a data set
  * Ranged: they have a consistent metric e.g. integers, floats
  * Factors: No consistent metric e.g.
    * Ordinal: ordered e.g. Likert scale
    * Categorical: unordered e.g. male/female/trans
* **Variable**: measures an attribute
* **Observation**: all values measured on a unit (e.g. subject, time) across attributes. 
* Each value belongs to an observation and a variable. 


---

## Tidy data - Semantics quiz

> - Q: Are `height` and `weight` variables or observations?

> - A: They are both variables. 

> - Q: Are `height` and `width` variables or observations?

> - A: They could be both variables **or** observations of a `dimension` variable. 

> - Conclusion: not always easy to make rules for what is a variable and what is an observation. 

---

## Tidy data - the rules

1. Every variable is a column
2. Every observation is a row
3. Every type of observational unit forms a table

* Variable vs observation - if there is ambiguity: 
  * **Wide format**: `area = height * width` then `height` and `width` are variables
  * **Long format**: summarise average height to average width then `height` and `width` are observations. 
  * more on this when plotting. 

--- 

## Tidy data - tools

<div class="rimage center"><img src="fig/tidyverse.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="100%" class="plot" /></div>


---{.build}

### `tidyr` - example

* Scores after 50 sec, 100 sec,..., 350 sec in a game
* Q: Why isn't this tidy?

<!-- html table generated in R 3.5.0 by xtable 1.8-3 package -->
<!-- Sun Nov 11 14:04:48 2018 -->
<table border=1>
<tr> <th>  </th> <th> Name </th> <th> 50 </th> <th> 100 </th> <th> 150 </th> <th> 200 </th> <th> 250 </th> <th> 300 </th> <th> 350 </th>  </tr>
  <tr> <td align="right"> 1 </td> <td> Carla </td> <td align="right"> 1.20 </td> <td align="right"> 1.80 </td> <td align="right"> 2.20 </td> <td align="right"> 2.30 </td> <td align="right"> 3.00 </td> <td align="right"> 2.50 </td> <td align="right"> 1.80 </td> </tr>
  <tr> <td align="right"> 2 </td> <td> Mace </td> <td align="right"> 1.50 </td> <td align="right"> 1.10 </td> <td align="right"> 1.90 </td> <td align="right"> 2.00 </td> <td align="right"> 3.60 </td> <td align="right"> 3.00 </td> <td align="right"> 2.50 </td> </tr>
  <tr> <td align="right"> 3 </td> <td> Lea </td> <td align="right"> 1.70 </td> <td align="right"> 1.60 </td> <td align="right"> 2.30 </td> <td align="right"> 2.70 </td> <td align="right"> 2.60 </td> <td align="right"> 2.20 </td> <td align="right"> 2.60 </td> </tr>
  <tr> <td align="right"> 4 </td> <td> Karen </td> <td align="right"> 1.30 </td> <td align="right"> 1.70 </td> <td align="right"> 1.90 </td> <td align="right"> 2.20 </td> <td align="right"> 3.20 </td> <td align="right"> 1.50 </td> <td align="right"> 1.90 </td> </tr>
   </table>



> - A: the columns are observations!

---

### `tidyr` - example

* use [`gather`](https://tidyr.tidyverse.org/reference/gather.html) to make tidy:

scores %>%
  # Gather ALL columns and give default names to columns
  gather() %>%
  head()   key value
1 Name Carla
2 Name  Mace
3 Name   Lea
4 Name Karen
5   50   1.2
6   50   1.5


---

### `tidyr` - example

* use [`gather`](https://tidyr.tidyverse.org/reference/gather.html) to make tidy:

scores %>%
  # Gather all columns and give custom names to columns
  gather(key="MyVariable", value="MyValue") %>%
  head()  MyVariable MyValue
1       Name   Carla
2       Name    Mace
3       Name     Lea
4       Name   Karen
5         50     1.2
6         50     1.5


---

### `tidyr` - example

* use [`gather`](https://tidyr.tidyverse.org/reference/gather.html) to make tidy:

scores %>%
  # Gather all columns except 'Name' and give custom names to columns
  gather(key="Time", value="Score", -Name) %>%
  head()   Name Time Score
1 Carla   50   1.2
2  Mace   50   1.5
3   Lea   50   1.7
4 Karen   50   1.3
5 Carla  100   1.8
6  Mace  100   1.1


--- 

### `dplyr` - example

* We may also want to create new variables in order to tidy data. 
* Q: Why isn't our data tidy? 
* Hint: `pdili` indicates whether there is any DILI at all. `t1dili` indicates that it is type 1 (the one we're interested in) and not type 2 or 3. 

df <- read.csv("../../data/original/dili_from_anti_TB_treatment.csv")head(df, 4)  id pdili t1dili agegroup sex weight rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv hbv alcohol
1  1     1      1    30/39   F   67.0  8.955224 4.477612  22.38806       NA   0   0   0       0
2  2     1      1    30/39   F   51.6 11.627907 5.813953  29.06977       NA   0  NA  NA       0
3  3     1      0    30/39   M   63.1  9.508717 4.754358  15.84786       NA   0   1   0      NA
4  4     1      1      40+   M   83.0  7.228916 3.614458  18.07229 4.819277   0   0   0       1
  liver_disease tb_site log10base_alt log10base_alp log10base_bili time_to_onset_of_pDILI
1             0       2      1.462398      1.740363      1.0000000                     55
2             0       2      0.698970      1.799341      0.7781513                      8
3             1       1      1.146128      2.000000      0.6989700                     50
4             0       2      1.491362      1.792392      1.1139433                     91


> - A: `pdili` and `t1dili` both refer to the same variable (type of DILI). 

---

### `dplyr` - example

* Q: Can we just use `gather` to make it tidy?

> - A: No

---

### `dplyr` - example

* Q: Can we just use `gather` to make it tidy?

* A: No - now there are two rows for every observation. *We need to make a new variable*

df %>% 
  gather(key='dili', value='value', c(pdili, t1dili)) %>%
  select(dili, value, everything()) %>%
  arrange(id) %>%
  head(4)    dili value id agegroup sex weight rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv hbv alcohol
1  pdili     1  1    30/39   F   67.0  8.955224 4.477612  22.38806       NA   0   0   0       0
2 t1dili     1  1    30/39   F   67.0  8.955224 4.477612  22.38806       NA   0   0   0       0
3  pdili     1  2    30/39   F   51.6 11.627907 5.813953  29.06977       NA   0  NA  NA       0
4 t1dili     1  2    30/39   F   51.6 11.627907 5.813953  29.06977       NA   0  NA  NA       0
  liver_disease tb_site log10base_alt log10base_alp log10base_bili time_to_onset_of_pDILI
1             0       2      1.462398      1.740363      1.0000000                     55
2             0       2      1.462398      1.740363      1.0000000                     55
3             0       2      0.698970      1.799341      0.7781513                      8
4             0       2      0.698970      1.799341      0.7781513                      8


---

### `dplyr` - example

* We can use `mutate` to create a new categorical variable called `dili` with the following levels based on `pdili` and `t1dili`. 
* Easiest way is to add `pdili` to `t1dili`: 
  
| `pdili`  | `t1dili` | `pdili` + `t1dili`  |`dili`  |
|:-:|:-:|:-:|:-:|
| 0  |  0  |  0 |'C' |
| 1  |  1 | 2   |'T1' |
| 1  |  0 | 1   |'T23'|

df %>%
  mutate(dili=factor(pdili+t1dili, labels=c('C', 'T23', 'T1'))) %>% # create new variable base on sum of two other variables
  mutate(pdili=NULL, t1dili=NULL) %>% # Drop columns
  select(dili, everything()) %>%
  head()  dili id agegroup sex weight rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv hbv alcohol
1   T1  1    30/39   F   67.0  8.955224 4.477612  22.38806       NA   0   0   0       0
2   T1  2    30/39   F   51.6 11.627907 5.813953  29.06977       NA   0  NA  NA       0
3  T23  3    30/39   M   63.1  9.508717 4.754358  15.84786       NA   0   1   0      NA
4   T1  4      40+   M   83.0  7.228916 3.614458  18.07229 4.819277   0   0   0       1
5   T1  5      40+   F   76.2  7.874016 3.937008  26.24672 5.249344   0   0   0      NA
6   T1  6    18/29   M   55.0 10.909091 5.454546  27.27273       NA   0   0   0       0
  liver_disease tb_site log10base_alt log10base_alp log10base_bili time_to_onset_of_pDILI
1             0       2      1.462398      1.740363      1.0000000                     55
2             0       2      0.698970      1.799341      0.7781513                      8
3             1       1      1.146128      2.000000      0.6989700                     50
4             0       2      1.491362      1.792392      1.1139433                     91
5             0       2      1.204120      1.897627      0.9030900                     14
6             0       1      1.724276      1.491362      1.1139433                      2


---

### Exercises

Navigate to `exercises/analysis.Rmd` and add code chunks to:
1. Load data into a data frame. 
2. Create a new variable called `dili` which has the following levels ('C', 'T1' and 'T23')
3. Delete the `pdili`, `t1dili` AND `id`, `time_to_onset_of_pDILI`


