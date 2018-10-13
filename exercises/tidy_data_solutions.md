---
title: "Tidy data solutions"
output: html_notebook
---


## Introduction
In this workbook we're going to be doing some basic data tidying exercises using *untidy* datasets we've created for you. First thing we have to do is import libraries: 


```r
library(tidyverse)
library(FSA) # for headtail function
```


## Global variables
The untidy data are in the directory, `data/untidy`, they are: 


```r
file_1 <- 'dili_table1.csv'
file_2 <- 'dili_table2.csv'
data_dir <- '../data/untidy/'
```

## The first dataframe
Let's first load and take a quick peek at the data:


```r
df1 <- read.csv(paste0(data_dir, file_1))
str(df1)
```

```
## 'data.frame':	305 obs. of  4 variables:
##  $ id           : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ agegroup     : Factor w/ 3 levels "18/29","30/39",..: 2 2 2 3 3 1 1 1 3 2 ...
##  $ Female_weight: num  67 51.6 NA NA 76.2 NA NA NA 56.5 NA ...
##  $ Male_weight  : num  NA NA 63.1 83 NA 55 57.8 56.4 NA 46.6 ...
```

```r
head(df1)
```

```
##   id agegroup Female_weight Male_weight
## 1  1    30/39          67.0          NA
## 2  2    30/39          51.6          NA
## 3  3    30/39            NA        63.1
## 4  4      40+            NA        83.0
## 5  5      40+          76.2          NA
## 6  6    18/29            NA        55.0
```

**Q**: Look at the tidy data document (it's listed in the resources folder) - what feature of this dataframe is untidy?

**A**: There are multiple variables in the columns `Female_weight` and `Male_weight`.  

---

**Q**: What should the table look like if it were to be tidy?  Write a markdown table with one data line entry (see [here](https://www.tablesgenerator.com/markdown_tables) for the syntax and how to automatically generate tables in markdown)


**A**: 

|id | agegroup | sex |weight |
|:-:|:-:       |:-:  |:-:   |
| 1 | 18/29    |  F  |  67   |

---

We're now going to build up, line by line, a method for making this dataframe tidy. To view the results of the manipulations, we'll use the `headtail()` function which shows three lines of the top and the bottom of the dataframe.  This way we can see what we've done.  Your answers should be code chunks which you should run.  You'll be using the `%>%` command chain functions, like this: 

```r
df1_tidy <- df1 %>% 
  function_1(arguments) %>%
  function_2(arguments)

headtail(df1_tidy)
```


**Q**: First we'll use  [`mutate`](https://dplyr.tidyverse.org/reference/mutate.html) to create an `F` and `M` columns which tell us whether there is a value in the `Female_weight` of the `Male_weight` column.  We'll use the `is.na()` and the unary negation operator `!`: 

**A**:


```r
df1_tidy <- df1 %>% 
  mutate(Female=!is.na(Female_weight), Male=!is.na(Male_weight))

headtail(df1_tidy)
```

```
##       id agegroup Female_weight Male_weight Female  Male
## 1      1    30/39          67.0          NA   TRUE FALSE
## 2      2    30/39          51.6          NA   TRUE FALSE
## 3      3    30/39            NA        63.1  FALSE  TRUE
## 303 1000    30/39          63.1          NA   TRUE FALSE
## 304 1049      40+            NA        38.6  FALSE  TRUE
## 305 1105    30/39            NA        77.0  FALSE  TRUE
```

---

**Q**: Now we must extract the weight from the columns and put it in a column called `weight`.  We'll use `mutate` again but this time we'll use the the `pmax(?, ??, na.rm=TRUE)` function.  You'll have to work out what goes in the two positions `?` and `??`

**A**: 


```r
df1_tidy <- df1 %>% 
  mutate(Female=!is.na(Female_weight), Male=!is.na(Male_weight)) %>%
  mutate(weight=pmax(Female_weight, Male_weight, na.rm=T))

headtail(df1_tidy)
```

```
##       id agegroup Female_weight Male_weight Female  Male weight
## 1      1    30/39          67.0          NA   TRUE FALSE   67.0
## 2      2    30/39          51.6          NA   TRUE FALSE   51.6
## 3      3    30/39            NA        63.1  FALSE  TRUE   63.1
## 303 1000    30/39          63.1          NA   TRUE FALSE   63.1
## 304 1049      40+            NA        38.6  FALSE  TRUE   38.6
## 305 1105    30/39            NA        77.0  FALSE  TRUE   77.0
```

---

**Q**: Now we can drop the `Female_weight` and `Male_weight` using [`select`](https://dplyr.tidyverse.org/reference/select.html). 

**A**:


```r
df1_tidy <- df1 %>% 
  mutate(Female=!is.na(Female_weight), Male=!is.na(Male_weight)) %>%
  mutate(weight=pmax(Female_weight, Male_weight, na.rm=T)) %>%
  select(-c(Female_weight, Male_weight))

headtail(df1_tidy)
```

```
##       id agegroup Female  Male weight
## 1      1    30/39   TRUE FALSE   67.0
## 2      2    30/39   TRUE FALSE   51.6
## 3      3    30/39  FALSE  TRUE   63.1
## 303 1000    30/39   TRUE FALSE   63.1
## 304 1049      40+  FALSE  TRUE   38.6
## 305 1105    30/39  FALSE  TRUE   77.0
```

---

**Q**: Create a new column called `sex` using `mutate` and [`if_else`](https://www.rdocumentation.org/packages/dplyr/versions/0.7.6/topics/if_else) to put a label `F` for female, `M` for male, or NULL if there's a missing value. 

**Hint**: If `F` and `M` are both false then `weight` must be `NA`; also, if `x=NA` then `x>0` is also `NA`. Use these facts to include `weight` in your logical statement in `if_else`. 

**A**: 


```r
df1_tidy <- df1 %>% 
  mutate(Female=!is.na(Female_weight), Male=!is.na(Male_weight)) %>%
  mutate(weight=pmax(Female_weight, Male_weight, na.rm=T)) %>%
  select(-c(Female_weight, Male_weight)) %>%
  mutate(sex=if_else(condition= Female & weight > 0, 'F', 'M', missing=NULL))

headtail(df1_tidy)
```

```
##       id agegroup Female  Male weight sex
## 1      1    30/39   TRUE FALSE   67.0   F
## 2      2    30/39   TRUE FALSE   51.6   F
## 3      3    30/39  FALSE  TRUE   63.1   M
## 303 1000    30/39   TRUE FALSE   63.1   F
## 304 1049      40+  FALSE  TRUE   38.6   M
## 305 1105    30/39  FALSE  TRUE   77.0   M
```

---

**Q**: Use select to drop the `Female` and `Male` column:

**A**: 


```r
df1_tidy <- df1 %>% 
  mutate(Female=!is.na(Female_weight), Male=!is.na(Male_weight)) %>%
  mutate(weight=pmax(Female_weight, Male_weight, na.rm=T)) %>%
  select(-c(Female_weight, Male_weight)) %>%
  mutate(sex=if_else(condition= Female & weight > 0, 'F', 'M', missing=NULL)) %>%
  select(-c(Female, Male))

headtail(df1_tidy)
```

```
##       id agegroup weight sex
## 1      1    30/39   67.0   F
## 2      2    30/39   51.6   F
## 3      3    30/39   63.1   M
## 303 1000    30/39   63.1   F
## 304 1049      40+   38.6   M
## 305 1105    30/39   77.0   M
```

---

## Second dataframe

Now let's do the same for the second dataframe


```r
df2 <- read.csv(paste0(data_dir,file_2))
str(df2)
```

```
## 'data.frame':	305 obs. of  17 variables:
##  $ id                    : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ pdili                 : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ t1dili                : int  1 1 0 1 1 1 1 1 1 1 ...
##  $ rifam_dpw             : num  8.96 11.63 9.51 7.23 7.87 ...
##  $ ison_dpw              : num  4.48 5.81 4.75 3.61 3.94 ...
##  $ pyraz_dpw             : num  22.4 29.1 15.8 18.1 26.2 ...
##  $ moxi_dpw              : num  NA NA NA 4.82 5.25 ...
##  $ hiv                   : int  0 0 0 0 0 0 1 0 0 0 ...
##  $ hcv                   : int  0 NA 1 0 0 0 0 0 0 0 ...
##  $ hbv                   : int  0 NA 0 0 0 0 0 0 0 0 ...
##  $ alcohol               : int  0 0 NA 1 NA 0 1 NA NA 1 ...
##  $ liver_disease         : int  0 0 1 0 0 0 0 0 0 0 ...
##  $ tb_site               : int  2 2 1 2 2 1 2 3 2 1 ...
##  $ log10base_alt         : num  1.462 0.699 1.146 1.491 1.204 ...
##  $ log10base_alp         : num  1.74 1.8 2 1.79 1.9 ...
##  $ log10base_bili        : num  1 0.778 0.699 1.114 0.903 ...
##  $ time_to_onset_of_pDILI: int  55 8 50 91 14 2 9 11 34 2 ...
```

```r
head(df2)
```

```
##   id pdili t1dili rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv hbv
## 1  1     1      1  8.955224 4.477612  22.38806       NA   0   0   0
## 2  2     1      1 11.627907 5.813953  29.06977       NA   0  NA  NA
## 3  3     1      0  9.508717 4.754358  15.84786       NA   0   1   0
## 4  4     1      1  7.228916 3.614458  18.07229 4.819277   0   0   0
## 5  5     1      1  7.874016 3.937008  26.24672 5.249344   0   0   0
## 6  6     1      1 10.909091 5.454546  27.27273       NA   0   0   0
##   alcohol liver_disease tb_site log10base_alt log10base_alp log10base_bili
## 1       0             0       2      1.462398      1.740363      1.0000000
## 2       0             0       2      0.698970      1.799341      0.7781513
## 3      NA             1       1      1.146128      2.000000      0.6989700
## 4       1             0       2      1.491362      1.792392      1.1139433
## 5      NA             0       2      1.204120      1.897627      0.9030900
## 6       0             0       1      1.724276      1.491362      1.1139433
##   time_to_onset_of_pDILI
## 1                     55
## 2                      8
## 3                     50
## 4                     91
## 5                     14
## 6                      2
```

**Q**: What is untidy about this dataframe (check the meta data at https://data.bris.ac.uk/datasets/1vdt21e4mhxxd27hso89cqmhhh/README.txt).

**A**: `pdili` and `t1dili` are both measuring the same thing.  They should be a single column with either `none`, `t1`, `t2_3` (there are three categories of DILI)

---

**Q**: Use mutate to create a new column which indicates `none` with either 1  or 0.  To do this note that `(TRUE)*1`/`(FALSE)*1 = 1`/`0`   You'll need to use [`select`](https://dplyr.tidyverse.org/reference/select.html) to move the new column to the left of the dataframe so you can see it easily (see the examples at the linked page for how to do this). 

**A**: 


```r
df2_tidy <- df2 %>% 
  mutate(none=(pdili==0)*1) %>%
  select(none, everything())

headtail(df2_tidy)
```

```
##     none   id pdili t1dili rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv
## 1      0    1     1      1  8.955224 4.477612  22.38806       NA   0   0
## 2      0    2     1      1 11.627907 5.813953  29.06977       NA   0  NA
## 3      0    3     1      0  9.508717 4.754358  15.84786       NA   0   1
## 303    1 1000     0      0  9.508717 4.754358  23.77179       NA   0   0
## 304    1 1049     0      0 15.544042 7.772021  25.90674       NA   0   0
## 305    1 1105     0      0  7.792208 3.896104  19.48052       NA   0   0
##     hbv alcohol liver_disease tb_site log10base_alt log10base_alp
## 1     0       0             0       2      1.462398      1.740363
## 2    NA       0             0       2      0.698970      1.799341
## 3     0      NA             1       1      1.146128      2.000000
## 303   0       0             0      NA      1.204120      1.886491
## 304   0       1             0      NA      0.845098      1.959041
## 305   0       0             0      NA      1.255273      1.929419
##     log10base_bili time_to_onset_of_pDILI
## 1        1.0000000                     55
## 2        0.7781513                      8
## 3        0.6989700                     50
## 303      0.9030900                     NA
## 304      0.8450980                     NA
## 305      1.0000000                     NA
```

---

**Q**: Now do the same for `t2_3`.  The:  rename `t1dili` to `t1` using `rename` (the documentation is the same as `select`), and remove the `pdili` variable. Note, you only need one `select` statement at the end (i.e. don't just copy and paste from previous answers)

**A**:


```r
df2_tidy <- df2 %>% 
  mutate(none=(pdili==0)*1) %>%
  mutate(t2_3=(pdili==1 & t1dili==0)*1) %>%
  rename(t1=t1dili) %>%
  select(none, t1, t2_3, everything(), -pdili)
headtail(df2_tidy)
```

```
##     none t1 t2_3   id rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv hbv
## 1      0  1    0    1  8.955224 4.477612  22.38806       NA   0   0   0
## 2      0  1    0    2 11.627907 5.813953  29.06977       NA   0  NA  NA
## 3      0  0    1    3  9.508717 4.754358  15.84786       NA   0   1   0
## 303    1  0    0 1000  9.508717 4.754358  23.77179       NA   0   0   0
## 304    1  0    0 1049 15.544042 7.772021  25.90674       NA   0   0   0
## 305    1  0    0 1105  7.792208 3.896104  19.48052       NA   0   0   0
##     alcohol liver_disease tb_site log10base_alt log10base_alp
## 1         0             0       2      1.462398      1.740363
## 2         0             0       2      0.698970      1.799341
## 3        NA             1       1      1.146128      2.000000
## 303       0             0      NA      1.204120      1.886491
## 304       1             0      NA      0.845098      1.959041
## 305       0             0      NA      1.255273      1.929419
##     log10base_bili time_to_onset_of_pDILI
## 1        1.0000000                     55
## 2        0.7781513                      8
## 3        0.6989700                     50
## 303      0.9030900                     NA
## 304      0.8450980                     NA
## 305      1.0000000                     NA
```

---

**Q**: Use [`gather`](https://tidyr.tidyverse.org/reference/gather.html) to create a new variable called `dili` which has three different `level`s: `none`, `t1`, `t2_3`.  You'll need to use `select` again to move it to the left hand side. 

**A**: 

```r
df2_tidy <- df2 %>% 
  mutate(none=(pdili==0)) %>%
  mutate(t2_3=(pdili==1 & t1dili==0)) %>%
  rename(t1=t1dili) %>%
  gather(key='dili',value='level', c(none, t1, t2_3)) %>%
  select(dili,level, everything(), -pdili)
  
headtail(df2_tidy)
```

```
##     dili level   id rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv hbv
## 1   none     0    1  8.955224 4.477612  22.38806       NA   0   0   0
## 2   none     0    2 11.627907 5.813953  29.06977       NA   0  NA  NA
## 3   none     0    3  9.508717 4.754358  15.84786       NA   0   1   0
## 913 t2_3     0 1000  9.508717 4.754358  23.77179       NA   0   0   0
## 914 t2_3     0 1049 15.544042 7.772021  25.90674       NA   0   0   0
## 915 t2_3     0 1105  7.792208 3.896104  19.48052       NA   0   0   0
##     alcohol liver_disease tb_site log10base_alt log10base_alp
## 1         0             0       2      1.462398      1.740363
## 2         0             0       2      0.698970      1.799341
## 3        NA             1       1      1.146128      2.000000
## 913       0             0      NA      1.204120      1.886491
## 914       1             0      NA      0.845098      1.959041
## 915       0             0      NA      1.255273      1.929419
##     log10base_bili time_to_onset_of_pDILI
## 1        1.0000000                     55
## 2        0.7781513                      8
## 3        0.6989700                     50
## 913      0.9030900                     NA
## 914      0.8450980                     NA
## 915      1.0000000                     NA
```

---

**Q**: What is dimension of this dataframe?  Look at it (by clikcing on the `df2_tidy` variable in the environment tab).  Which values of `level` can be dropped?  Drop them using [`filter`](https://dplyr.tidyverse.org/reference/filter.html) and then drop the `level` column. Arrange the table in asceding values of `id`

**A**: 

```r
df2_tidy <- df2 %>% 
  mutate(none=(pdili==0)) %>%
  mutate(t2_3=(pdili==1 & t1dili==0)) %>%
  rename(t1=t1dili) %>%
  gather(key='dili',value='level', c(none, t1, t2_3)) %>%
  filter(level==1) %>%
  select(dili,-level, everything(), -pdili) %>%
  arrange(id)
 
headtail(df2_tidy)
```

```
##     dili   id rifam_dpw ison_dpw pyraz_dpw moxi_dpw hiv hcv hbv alcohol
## 1     t1    1  8.955224 4.477612  22.38806       NA   0   0   0       0
## 2     t1    2 11.627907 5.813953  29.06977       NA   0  NA  NA       0
## 3   t2_3    3  9.508717 4.754358  15.84786       NA   0   1   0      NA
## 303 none 1000  9.508717 4.754358  23.77179       NA   0   0   0       0
## 304 none 1049 15.544042 7.772021  25.90674       NA   0   0   0       1
## 305 none 1105  7.792208 3.896104  19.48052       NA   0   0   0       0
##     liver_disease tb_site log10base_alt log10base_alp log10base_bili
## 1               0       2      1.462398      1.740363      1.0000000
## 2               0       2      0.698970      1.799341      0.7781513
## 3               1       1      1.146128      2.000000      0.6989700
## 303             0      NA      1.204120      1.886491      0.9030900
## 304             0      NA      0.845098      1.959041      0.8450980
## 305             0      NA      1.255273      1.929419      1.0000000
##     time_to_onset_of_pDILI level
## 1                       55     1
## 2                        8     1
## 3                       50     1
## 303                     NA     1
## 304                     NA     1
## 305                     NA     1
```

---


## Putting it together

**Q**: We have two tidy dataframes.  How many should we have?

**A**: Both tables refer to the same observational units so we should combine them! 

---

**Q**: Use the [`join`](https://dplyr.tidyverse.org/reference/join.html) function to join the two dataframes by matching on the `id` variable. It shouldn't matter which type of join you use - *however* you should use one that will allow you to check whether there have been data lost (or added by not matching properly). Call the new dataframe `df_tidy`

**A**: Use the `full_join` and then check whether there are any extra rows or columns by comparing the `dim()` on the three dataframes. 


```r
df_tidy <- full_join(df1_tidy, df2_tidy, by='id')
headtail(df_tidy)
```

```
##       id agegroup weight sex dili rifam_dpw ison_dpw pyraz_dpw moxi_dpw
## 1      1    30/39   67.0   F   t1  8.955224 4.477612  22.38806       NA
## 2      2    30/39   51.6   F   t1 11.627907 5.813953  29.06977       NA
## 3      3    30/39   63.1   M t2_3  9.508717 4.754358  15.84786       NA
## 303 1000    30/39   63.1   F none  9.508717 4.754358  23.77179       NA
## 304 1049      40+   38.6   M none 15.544042 7.772021  25.90674       NA
## 305 1105    30/39   77.0   M none  7.792208 3.896104  19.48052       NA
##     hiv hcv hbv alcohol liver_disease tb_site log10base_alt log10base_alp
## 1     0   0   0       0             0       2      1.462398      1.740363
## 2     0  NA  NA       0             0       2      0.698970      1.799341
## 3     0   1   0      NA             1       1      1.146128      2.000000
## 303   0   0   0       0             0      NA      1.204120      1.886491
## 304   0   0   0       1             0      NA      0.845098      1.959041
## 305   0   0   0       0             0      NA      1.255273      1.929419
##     log10base_bili time_to_onset_of_pDILI level
## 1        1.0000000                     55     1
## 2        0.7781513                      8     1
## 3        0.6989700                     50     1
## 303      0.9030900                     NA     1
## 304      0.8450980                     NA     1
## 305      1.0000000                     NA     1
```

```r
dim(df1_tidy)
```

```
## [1] 305   4
```

```r
dim(df2_tidy)
```

```
## [1] 305  17
```

```r
dim(df_tidy)
```

```
## [1] 305  20
```

---


**Q**: Now save this dataframe as a csv (`write_csv`) in the `data/processed` directory as `dili-tidy.csv` and commit these changes to the git repo push to the `participant` branch of your Github. 
**A**: 


```r
write.csv(df_tidy, path='../data/processed/dili-tidy.csv')
```

```
## Error in write.table(df_tidy, path = "../data/processed/dili-tidy.csv", : unused argument (path = "../data/processed/dili-tidy.csv")
```

In the home directory: 
```
$ git add exercises/tidy_data.Rmd
$ git commit -m "Finished tidy data problems"
$ git push origin participant
```

Well done! 


