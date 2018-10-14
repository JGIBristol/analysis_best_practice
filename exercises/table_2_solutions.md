---
title: "Reproducing Table 2"
output: html_notebook
---

## Introduction

In this notebook we'll take you through some manipulations in order to reproduce some of table 2 from the paper, reproduced below:

![](fig/Table 2.png)

The figure comprises many different statistics: 

  1. median
  2. interquartile range
  3. total number of subjects with a particular variable measured (`n=178` subjects with weight measurements) 
  4. fraction of subjects with a particular variable (e.g. `4/185` are HIV positive)
  5. p-values for between group comparisons. 
  
We're not going to calculate p-values here although you're more than welcome to use this opportunity to do so. 

The main object of this workbook is to get used to using `group_by` and `summarise` in order to calculate summary statistics.  This should form a part of any statistical analysis. We'll go through it statistic by statistic. 

## Load data and libraries

Let's load the libraries and data: 

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──
```

```
## ✔ ggplot2 3.0.0     ✔ purrr   0.2.5
## ✔ tibble  1.4.2     ✔ dplyr   0.7.5
## ✔ tidyr   0.8.1     ✔ stringr 1.3.1
## ✔ readr   1.1.1     ✔ forcats 0.3.0
```

```
## ── Conflicts ────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

```r
library(FSA)
```

```
## ## FSA v0.8.20. See citation('FSA') if used in publication.
## ## Run fishR() for related website and fishR('IFAR') for related book.
```

```r
df <- read.csv('~/Google Drive/Courses/Analysis-best-practice/data/processed/dili-tidy.csv')
```

Take a quick peek at the head to make sure it's what we wanted: 


```r
head(df)
```

```
##   id agegroup weight sex dili rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv
## 1  1    30/39   67.0   F   t1  8.955224 4.477612  22.38806       NA   0
## 2  2    30/39   51.6   F   t1 11.627907 5.813953  29.06977       NA   0
## 3  3    30/39   63.1   M t2_3  9.508717 4.754358  15.84786       NA   0
## 4  4      40+   83.0   M   t1  7.228916 3.614458  18.07229 4.819277   0
## 5  5      40+   76.2   F   t1  7.874016 3.937008  26.24672 5.249344   0
## 6  6    18/29   55.0   M   t1 10.909091 5.454546  27.27273       NA   0
##   hcv hbv alcohol liver_disease tb_site log10base_alt log10base_alp
## 1   0   0       0             0       2      1.462398      1.740363
## 2  NA  NA       0             0       2      0.698970      1.799341
## 3   1   0      NA             1       1      1.146128      2.000000
## 4   0   0       1             0       2      1.491362      1.792392
## 5   0   0      NA             0       2      1.204120      1.897627
## 6   0   0       0             0       1      1.724276      1.491362
##   log10base_bili time_to_onset_of_pDILI
## 1      1.0000000                     55
## 2      0.7781513                      8
## 3      0.6989700                     50
## 4      1.1139433                     91
## 5      0.9030900                     14
## 6      1.1139433                      2
```

## Clean up the dataframe

We're not going to need all of these columns so let's just drop them:


```r
df <- select(df, -c(sex, tb_site, time_to_onset_of_pDILI, agegroup))
head(df)
```

```
##   id weight dili rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv hbv alcohol
## 1  1   67.0   t1  8.955224 4.477612  22.38806       NA   0   0   0       0
## 2  2   51.6   t1 11.627907 5.813953  29.06977       NA   0  NA  NA       0
## 3  3   63.1 t2_3  9.508717 4.754358  15.84786       NA   0   1   0      NA
## 4  4   83.0   t1  7.228916 3.614458  18.07229 4.819277   0   0   0       1
## 5  5   76.2   t1  7.874016 3.937008  26.24672 5.249344   0   0   0      NA
## 6  6   55.0   t1 10.909091 5.454546  27.27273       NA   0   0   0       0
##   liver_disease log10base_alt log10base_alp log10base_bili
## 1             0      1.462398      1.740363      1.0000000
## 2             0      0.698970      1.799341      0.7781513
## 3             1      1.146128      2.000000      0.6989700
## 4             0      1.491362      1.792392      1.1139433
## 5             0      1.204120      1.897627      0.9030900
## 6             0      1.724276      1.491362      1.1139433
```

While we don't really need `id`, we'll keep it to show which observations get changed/dropped etc. 

The *Controls* in the table are those with `dili==none` and the *DILI cases* are those with `dili==t1`.

**Q**: Use the [`filter`](https://dplyr.tidyverse.org/reference/filter.html) command to remove all those observations which are not either `t1` or `none`. You'll need the `or` logical operator which is `|`. 

**A**: 

```r
df <- filter(df, dili=='t1' | dili=='none')
headtail(df)
```

```
##       id weight dili rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv hbv
## 1      1   67.0   t1  8.955224 4.477612  22.38806       NA   0   0   0
## 2      2   51.6   t1 11.627907 5.813953  29.06977       NA   0  NA  NA
## 3      4   83.0   t1  7.228916 3.614458  18.07229 4.819277   0   0   0
## 275 1000   63.1 none  9.508717 4.754358  23.77179       NA   0   0   0
## 276 1049   38.6 none 15.544042 7.772021  25.90674       NA   0   0   0
## 277 1105   77.0 none  7.792208 3.896104  19.48052       NA   0   0   0
##     alcohol liver_disease log10base_alt log10base_alp log10base_bili
## 1         0             0      1.462398      1.740363      1.0000000
## 2         0             0      0.698970      1.799341      0.7781513
## 3         1             0      1.491362      1.792392      1.1139433
## 275       0             0      1.204120      1.886491      0.9030900
## 276       1             0      0.845098      1.959041      0.8450980
## 277       0             0      1.255273      1.929419      1.0000000
```

Let's rename the `dili` levels to be `none -> control` and `t1 -> dili`.  This will make the summary headings more informative. For that we'll use the [`forcats`](https://forcats.tidyverse.org/) package. The documentation isn't so good for this, see the [*R for data science*](http://r4ds.had.co.nz/factors.html) chapter on factors (section 15.5). 


```r
df <- mutate(df, dili=fct_recode(dili, 
                             "dili"="t1", 
                             "control"="none"))
headtail(df)
```

```
##       id weight    dili rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv hbv
## 1      1   67.0    dili  8.955224 4.477612  22.38806       NA   0   0   0
## 2      2   51.6    dili 11.627907 5.813953  29.06977       NA   0  NA  NA
## 3      4   83.0    dili  7.228916 3.614458  18.07229 4.819277   0   0   0
## 275 1000   63.1 control  9.508717 4.754358  23.77179       NA   0   0   0
## 276 1049   38.6 control 15.544042 7.772021  25.90674       NA   0   0   0
## 277 1105   77.0 control  7.792208 3.896104  19.48052       NA   0   0   0
##     alcohol liver_disease log10base_alt log10base_alp log10base_bili
## 1         0             0      1.462398      1.740363      1.0000000
## 2         0             0      0.698970      1.799341      0.7781513
## 3         1             0      1.491362      1.792392      1.1139433
## 275       0             0      1.204120      1.886491      0.9030900
## 276       1             0      0.845098      1.959041      0.8450980
## 277       0             0      1.255273      1.929419      1.0000000
```

**Q**: There's one last problem.  The units of the *ALT*, *ALP* and *bili* variables.  They're all in log10 units.  here we can use the [`mutate_at`](https://dplyr.tidyverse.org/reference/summarise_all.html) function, see one of the examples there - you'll also need to use the following function instead of `log`:


```r
ten_2_power <- function(x) 10**x
```

Then rename the them by using [`rename_at`](https://dplyr.tidyverse.org/reference/select_all.html): 

```r
rename_at(vars(matches("log")), funs(str_replace_all(., 'log10base_', '')))
```

Hint - figure out the correct functions to use first and then resave the dataframe. 

**A**:

```r
df <- df %>% 
  mutate_at(vars(matches("log")),ten_2_power ) %>%
  rename_at(vars(matches("log")), funs(str_replace_all(., 'log10base_', '')))
```


## Number of observations 

Now we have all our observations and only the columns we want.  

**Q**: use [`summarise`](https://dplyr.tidyverse.org/reference/summarise.html) with the summary statistic `n()` to calculate the number of rows in the dataframe. Call the summary statistic `num_obs`. 

**A**: 

```r
df %>%
  summarise(num_obs=n())
```

```
##   num_obs
## 1     277
```

---

Not all that useful.  Let's increase it's usefulness by calling  [`group_by`](https://dplyr.tidyverse.org/reference/group_by.html) first. 

**Q**: use `group_by` to calculate the number of observations the two levels of `dili`: 

**A**: 

```r
df %>%
  group_by(dili) %>%
  summarise(num_obs = n())
```

```
## # A tibble: 2 x 2
##   dili    num_obs
##   <fct>     <int>
## 1 control     200
## 2 dili         77
```

---

This is better.  Let's try to summarise the other variables.   To do this, we'll have to collect all the other columns into two columns - one that tells us what the variable is and one to tell us what the value for that variable is.  To do this we'll use [`gather`](https://tidyr.tidyverse.org/reference/gather.html). 

**Q**: Discard the `group_by` line from above and gather all columns except `id` and `dili` into a key=`characteristic` and value=`value` column, pipe the results into `headtail()`. 

**A**: 


```r
df %>%
  gather(key='characteristic', value='value', -c(id, dili)) %>%
  headtail()
```

```
##        id    dili characteristic value
## 1       1    dili         weight  67.0
## 2       2    dili         weight  51.6
## 3       4    dili         weight  83.0
## 3599 1000 control           bili   8.0
## 3600 1049 control           bili   7.0
## 3601 1105 control           bili  10.0
```

---

**Q**: Now we need to count the number of observations of each characteristic for `dili==none` and `dili==t1`. We can use a single call to `group_by` to do this. If you put two variables in the `group_by` call it will group them hierarchically.  We want to group by `dili` and `characteristic` - you decide which order to put them in (try both and see what happens).  After the `group_by` call, count the number of observations with `summarise`. 

**A**: 


```r
df %>%
  gather(key='characteristic', value='value', -c(id, dili)) %>%
  group_by(characteristic, dili) %>%
  summarise(num_obs=n()) 
```

```
## # A tibble: 26 x 3
## # Groups:   characteristic [?]
##    characteristic dili    num_obs
##    <chr>          <fct>     <int>
##  1 alcohol        control     200
##  2 alcohol        dili         77
##  3 alp            control     200
##  4 alp            dili         77
##  5 alt            control     200
##  6 alt            dili         77
##  7 bili           control     200
##  8 bili           dili         77
##  9 hbv            control     200
## 10 hbv            dili         77
## # ... with 16 more rows
```

---

**Q**: There's something obviously wrong here - the number of observations are the same for each characteristic.  This is because the missing values still count as an observation.  Instead of counting the number of observations using `n()` we will have to:

  1. convert the values to `FALSE/TRUE` if they `NA` or not using `!is.na()` (what does `!` do?)
  2. sum these logicals (`TRUE=1`, `FALSE=0`) using `sum()`. 

So change the formula in `summarise` to count the number of non-NA values. 
**A**: 


```r
df %>%
  gather(key='characteristic', value='value', -c(id, dili)) %>%
  group_by(characteristic, dili) %>%
  summarise(num_obs=sum(!is.na(value))) 
```

```
## # A tibble: 26 x 3
## # Groups:   characteristic [?]
##    characteristic dili    num_obs
##    <chr>          <fct>     <int>
##  1 alcohol        control     179
##  2 alcohol        dili         56
##  3 alp            control     187
##  4 alp            dili         77
##  5 alt            control     185
##  6 alt            dili         77
##  7 bili           control     185
##  8 bili           dili         77
##  9 hbv            control     180
## 10 hbv            dili         74
## # ... with 16 more rows
```

Great!  this is the information we need but the format isn't very nice. Let's have two columns with `dili=none` and `dili=t1` and the counts as the values. 

**Q**: Use [`spread`](https://tidyr.tidyverse.org/reference/spread.html) to split the values in `num_obs` into two columns labelled `none` and `t1`: 

**A**: 


```r
df %>%
  gather(key='characteristic', value='value', -c(id, dili)) %>%
  group_by(characteristic, dili) %>%
  summarise(num_obs=sum(!is.na(value))) %>%
  spread(key=dili, value=num_obs)
```

```
## # A tibble: 13 x 3
## # Groups:   characteristic [13]
##    characteristic control  dili
##    <chr>            <int> <int>
##  1 alcohol            179    56
##  2 alp                187    77
##  3 alt                185    77
##  4 bili               185    77
##  5 hbv                180    74
##  6 hcv                179    73
##  7 hiv                185    69
##  8 ison_dpw           178    74
##  9 liver_disease      186    77
## 10 moxi_dpw            21    10
## 11 pyraz_dpw          178    74
## 12 rifam_dpw          178    74
## 13 weight             178    74
```

## Median

Now we have the pattern for summarising the data into nice tables, it should be easy to calculate the median for those variables which are double precision (i.e. not 0/1 integer variables like `hiv`).  

**Q**: Use the `select_if` function to select only those variables which are floating ponit numbers (not integers) OR called `dili`.  To do this you'll need to use this [example](https://stackoverflow.com/questions/39592879/r-dpylr-select-if-with-multiple-conditions)  from `aichao` with  the [`is_double`](https://www.rdocumentation.org/packages/purrr/versions/0.2.2.2/topics/type-predicates) function form the tidyverse [`purrr`](https://purrr.tidyverse.org/) package.  


**A**:

```r
df %>%
  select_if(function(col) is_double(col) | all(col == .$dili)) %>%
  head()
```

```
##   weight dili rifam_dpw ison_dpw pyraz_dpw moxi_dpw      alt       alp
## 1   67.0 dili  8.955224 4.477612  22.38806       NA 29.00001  54.99999
## 2   51.6 dili 11.627907 5.813953  29.06977       NA  5.00000  63.00001
## 3   83.0 dili  7.228916 3.614458  18.07229 4.819277 31.00000  62.00000
## 4   76.2 dili  7.874016 3.937008  26.24672 5.249344 16.00000  79.00000
## 5   55.0 dili 10.909091 5.454546  27.27273       NA 52.99999  31.00000
## 6   57.8 dili 10.380623 5.190311  25.95156       NA 29.00001 121.00001
##   bili
## 1   10
## 2    6
## 3   13
## 4    8
## 5   13
## 6    7
```

---

**Q**: Now we have that selection pattern, we can use a similar set of functions as before but replacing the `num_obs = sum(!is.na())` with the `median(..., na.rm=T)` function. You'll need to adjust the `gather` function as well. 

**A**: 

```r
df %>%
  select_if(function(col) is_double(col) | all(col == .$dili)) %>%
  gather(key='characteristic', value='value', -c(dili)) %>%
  group_by(characteristic, dili) %>%
  summarise(median=median(value, na.rm = T)) %>%
  spread(key=dili, value=median)
```

```
## # A tibble: 8 x 3
## # Groups:   characteristic [8]
##   characteristic control  dili
##   <chr>            <dbl> <dbl>
## 1 alp              86.0  98.0 
## 2 alt              19.0  24.0 
## 3 bili              8.00  8.00
## 4 ison_dpw          4.85  5.57
## 5 moxi_dpw          6.15  7.67
## 6 pyraz_dpw        24.4  25.8 
## 7 rifam_dpw         9.68  9.98
## 8 weight           61.2  53.8
```

---

## Interquartile range

**Q**: The lower and upper quartile should now be likewise simple. Look at  `summarise` documentation to get the correct function. Call the lower quartile `lq` and the upper quartile `uq`.  Note in this one you'll not be able to `spread` the columns without  a bit more work (you can do it though using [`unite`](https://tidyr.tidyverse.org/reference/unite.html)) and making the numbers characters. I've included this code as well in the solutions. 

**A**: 


```r
df %>%
  select_if(function(col) is_double(col) | all(col == .$dili)) %>%
  gather(key='characteristic', value='value', -c(dili)) %>%
  group_by(characteristic, dili) %>%
  summarise(lq=quantile(value, na.rm = T,probs = 0.25 ), uq=quantile(value, na.rm = T,probs = 0.75 ))
```

```
## # A tibble: 16 x 4
## # Groups:   characteristic [?]
##    characteristic dili       lq     uq
##    <chr>          <fct>   <dbl>  <dbl>
##  1 alp            control 71.0  102.  
##  2 alp            dili    75.0  135.  
##  3 alt            control 14.0   29.0 
##  4 alt            dili    17.0   32.0 
##  5 bili           control  5.00  10   
##  6 bili           dili     6.00  12.0 
##  7 ison_dpw       control  4.31   5.45
##  8 ison_dpw       dili     4.62   6.23
##  9 moxi_dpw       control  5.71   7.04
## 10 moxi_dpw       dili     5.96   8.00
## 11 pyraz_dpw      control 21.5   27.5 
## 12 pyraz_dpw      dili    22.8   29.7 
## 13 rifam_dpw      control  8.62  10.7 
## 14 rifam_dpw      dili     9.01  11.1 
## 15 weight         control 54.6   69.5 
## 16 weight         dili    48.2   64.9
```


```r
df %>%
  select_if(function(col) is_double(col) | all(col == .$dili)) %>%
  gather(key='characteristic', value='value', -c(dili)) %>%
  group_by(characteristic, dili) %>%
  summarise(lq=quantile(value, na.rm = T,probs = 0.25 ), uq=quantile(value, na.rm = T,probs = 0.75 )) %>%
  # rounding and then saving as characters is an easy way of displaying fewer decimal places. There are other ways. 
  mutate(lq = as.character(round(lq, 1)), uq = as.character(round(uq, 1))) %>%
  unite("iqr", c(lq,uq),  sep=" - ") %>%
  spread(key=dili, value=iqr)
```

```
## # A tibble: 8 x 3
## # Groups:   characteristic [8]
##   characteristic control     dili       
##   <chr>          <chr>       <chr>      
## 1 alp            71 - 102    75 - 135   
## 2 alt            14 - 29     17 - 32    
## 3 bili           5 - 10      6 - 12     
## 4 ison_dpw       4.3 - 5.5   4.6 - 6.2  
## 5 moxi_dpw       5.7 - 7     6 - 8      
## 6 pyraz_dpw      21.5 - 27.5 22.8 - 29.7
## 7 rifam_dpw      8.6 - 10.7  9 - 11.1   
## 8 weight         54.6 - 69.5 48.1 - 64.9
```


---

## %/Fraction

For integer variables (which really should be factor variables), such as `hiv`, we need to count the number of `0`s and the `1` in each level. 

**Q**: First, let's turn integer variables into factor variables using [`mutate_if`](https://dplyr.tidyverse.org/reference/summarise_all.html) and the functions `is.integer()` and `as.factor()`.

**A**:

```r
df %>%
  mutate_if(is.integer, as.factor) %>%
  head() 
```

```
##   id weight dili rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv  hcv  hbv
## 1  1   67.0 dili  8.955224 4.477612  22.38806       NA   0    0    0
## 2  2   51.6 dili 11.627907 5.813953  29.06977       NA   0 <NA> <NA>
## 3  4   83.0 dili  7.228916 3.614458  18.07229 4.819277   0    0    0
## 4  5   76.2 dili  7.874016 3.937008  26.24672 5.249344   0    0    0
## 5  6   55.0 dili 10.909091 5.454546  27.27273       NA   0    0    0
## 6  7   57.8 dili 10.380623 5.190311  25.95156       NA   1    0    0
##   alcohol liver_disease      alt       alp bili
## 1       0             0 29.00001  54.99999   10
## 2       0             0  5.00000  63.00001    6
## 3       1             0 31.00000  62.00000   13
## 4    <NA>             0 16.00000  79.00000    8
## 5       0             0 52.99999  31.00000   13
## 6       1             0 29.00001 121.00001    7
```

**Q**: Now it's easy just to select `factors` by using `select_if` with `is.factor`:

**A**: 


```r
df %>%
  mutate_if(is.integer, as.factor) %>%
  select_if(is.factor) %>%
  head() 
```

```
##   id dili hiv  hcv  hbv alcohol liver_disease
## 1  1 dili   0    0    0       0             0
## 2  2 dili   0 <NA> <NA>       0             0
## 3  4 dili   0    0    0       1             0
## 4  5 dili   0    0    0    <NA>             0
## 5  6 dili   0    0    0       0             0
## 6  7 dili   1    0    0       1             0
```

---

**Q**: We can `gather` in the same way as before.  Note, that this time we need to gather everything *except* `id` and `dili` as `id` is an integer variable. 

**A**: 

```r
df %>%
  mutate_if(is.integer, as.factor) %>%
  select_if(is.factor) %>%
  gather(key='characteristic', value='value', -c(id, dili)) %>%
  head() 
```

```
##   id dili characteristic value
## 1  1 dili            hiv     0
## 2  2 dili            hiv     0
## 3  4 dili            hiv     0
## 4  5 dili            hiv     0
## 5  6 dili            hiv     0
## 6  7 dili            hiv     1
```

---

**Q**: The key to counting each value of each variable is to `group_by` `dili`, `characteristic` **AND** `value` and then count the non-`NA` values as we did before. 

**A**: 

```r
df %>%
  mutate_if(is.integer, as.factor) %>%
  select_if(is.factor) %>%
  gather(key='characteristic', value='value', -c(id, dili)) %>%
  group_by(dili, characteristic, value) %>%
  summarise(num_obs=sum(!is.na(value)))
```

```
## # A tibble: 28 x 4
## # Groups:   dili, characteristic [?]
##    dili    characteristic value num_obs
##    <fct>   <chr>          <chr>   <int>
##  1 control alcohol        0         167
##  2 control alcohol        1          12
##  3 control alcohol        <NA>        0
##  4 control hbv            0         176
##  5 control hbv            1           4
##  6 control hbv            <NA>        0
##  7 control hcv            0         176
##  8 control hcv            1           3
##  9 control hcv            <NA>        0
## 10 control hiv            0         181
## # ... with 18 more rows
```

---

**Q**: `spread`  `num_obs` by `value` column.  We should note that once we've `spread` the values, any `NA` represent `0`s - not actually missing values.  (Why?)  So after we `spread` the values, we can just convert all `NA`s to `0`s using the following: 

```r
mutate_all(funs(replace(., is.na(.), 0)))
```

**A**:

```r
df %>%
  mutate_if(is.integer, as.factor) %>%
  select_if(is.factor) %>%
  gather(key='characteristic', value='value', -c(id, dili)) %>%
  group_by(dili, characteristic, value) %>%
  summarise(num_obs=sum(!is.na(value))) %>%
  spread(key=value, value=num_obs) %>%
  mutate_all(funs(replace(., is.na(.), 0)))
```

```
## # A tibble: 10 x 5
## # Groups:   dili, characteristic [10]
##    dili    characteristic   `0`   `1` `<NA>`
##    <fct>   <chr>          <dbl> <dbl>  <dbl>
##  1 control alcohol          167    12      0
##  2 control hbv              176     4      0
##  3 control hcv              176     3      0
##  4 control hiv              181     4      0
##  5 control liver_disease    182     4      0
##  6 dili    alcohol           40    16      0
##  7 dili    hbv               74     0      0
##  8 dili    hcv               72     1      0
##  9 dili    hiv               64     5      0
## 10 dili    liver_disease     74     3      0
```

---

**Q**: If you want you can now combine the `'0'` and `'1'` (note - they're strings, not numbers) columns using `unite` (and call it `fraction`), select the `dili`, `characteristic` and `fraction` columns and finally `spread` the `fraction` column by `dili`. 

**A**:

```r
df %>%
  select_if(function(col) is_integer(col) | all(col == .$dili)) %>%
  gather(key='characteristic', value='value', -c(id, dili)) %>%
  group_by(dili, characteristic, value) %>%
  summarise(num_obs=sum(!is.na(value))) %>%
  spread(key=value, value=num_obs) %>%
  mutate_all(funs(replace(., is.na(.), 0))) %>%
  unite("fraction", c('1','0'),  sep="/") %>%
  select(c(dili, characteristic, fraction)) %>%
  spread(key=dili, value=fraction)
```

```
## # A tibble: 5 x 3
## # Groups:   characteristic [5]
##   characteristic control dili 
##   <chr>          <chr>   <chr>
## 1 alcohol        12/167  16/40
## 2 hbv            4/176   0/74 
## 3 hcv            3/176   1/72 
## 4 hiv            4/181   5/64 
## 5 liver_disease  4/182   3/74
```

---


Now knit this into the `html` notebook and then: 
In the home directory: 
```
$ git add exercises/tidy_data.Rmd
$ git commit -m "Finished reproducing table 2"
$ git push origin master
```

Well done! 
