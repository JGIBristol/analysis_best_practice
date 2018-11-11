Introduction
------------

In this workbook we're going to be doing some basic data tidying
exercises using *untidy* datasets we've created for you. We're going to
make use of the `tidyverse`. For each function we use there is a link to
its reference on the web. It will be expected that you follow that link
and read the documentation and **especially** the examples. This goes
for all subsequent exercise books.

Import libraries
----------------

First thing we have to do is import libraries:

    library(tidyverse)

    ## Warning: package 'dplyr' was built under R version 3.5.1

    library(FSA) # for headtail function

Global variables
----------------

The untidy data are in the directory, `data/untidy`, they are:

    file_1 <- 'dili_table1.csv'
    file_2 <- 'dili_table2.csv'
    data_dir <- '~/Google Drive/Courses/Analysis-best-practice/data/untidy/'

The first dataframe
-------------------

Let's first load and take a quick peek at the data:

    df1 <- read.csv(paste0(data_dir, file_1))
    str(df1)

    ## 'data.frame':    305 obs. of  4 variables:
    ##  $ id           : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ agegroup     : Factor w/ 3 levels "18/29","30/39",..: 2 2 2 3 3 1 1 1 3 2 ...
    ##  $ Female_weight: num  67 51.6 NA NA 76.2 NA NA NA 56.5 NA ...
    ##  $ Male_weight  : num  NA NA 63.1 83 NA 55 57.8 56.4 NA 46.6 ...

    head(df1)

    ##   id agegroup Female_weight Male_weight
    ## 1  1    30/39          67.0          NA
    ## 2  2    30/39          51.6          NA
    ## 3  3    30/39            NA        63.1
    ## 4  4      40+            NA        83.0
    ## 5  5      40+          76.2          NA
    ## 6  6    18/29            NA        55.0

**Q**: Look at the tidy data document (it's listed in the resources
folder) - what feature of this dataframe is untidy?

**A**: Two varibles in a column
-------------------------------

**Q**: What should the table look like if it were to be tidy? Write a
markdown table with one data line entry (see
[here](https://www.tablesgenerator.com/markdown_tables) for the syntax
and how to automatically generate tables in markdown)

**A**:

<table>
<thead>
<tr class="header">
<th align="center">id</th>
<th>agegroup</th>
<th>sex</th>
<th>weight</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">1</td>
<td>30/39</td>
<td>F</td>
<td>67</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

We're now going to build up, line by line, a method for making this
dataframe tidy. To view the results of the manipulations, we'll use the
`headtail()` function which shows three lines of the top and the bottom
of the dataframe. This way we can see what we've done. Your answers
should be code chunks which you should run. You'll be using the `%>%`
command chain functions, like this:

    df1_tidy <- df1 %>% 
      function_1(arguments) %>%
      function_2(arguments)

    headtail(df1_tidy)

**Q**: First we'll use
[`mutate`](https://dplyr.tidyverse.org/reference/mutate.html) to create
an `F` and `M` columns which tell us whether there is a value in the
`Female_weight` of the `Male_weight` column. We'll use the `is.na()` and
the unary negation operator `!`:

**A**:

------------------------------------------------------------------------

**Q**: Now we must extract the weight from the columns and put it in a
column called `weight`. We'll use `mutate` again but this time we'll use
the the `pmax(?, ??, na.rm=TRUE)` function. You'll have to work out what
goes in the two positions `?` and `??`

**A**:

------------------------------------------------------------------------

**Q**: Now we can drop the `Female_weight` and `Male_weight` using
[`select`](https://dplyr.tidyverse.org/reference/select.html).

**A**:

------------------------------------------------------------------------

**Q**: Create a new column called `sex` using `mutate` and
[`if_else`](https://www.rdocumentation.org/packages/dplyr/versions/0.7.6/topics/if_else)
to put a label `F` for female, `M` for male, or NULL if there's a
missing value.

**Hint**: If `F` and `M` are both false then `weight` must be `NA`;
also, if `x=NA` then `x>0` is also `NA`. Use these facts to include
`weight` in your logical statement in `if_else`.

**A**:

------------------------------------------------------------------------

**Q**: Use select to drop the `Female` and `Male` column:

**A**:

------------------------------------------------------------------------

Second dataframe
----------------

Now let's do the same for the second dataframe

    df2 <- read.csv(paste0(data_dir,file_2))
    str(df2)

    ## 'data.frame':    305 obs. of  17 variables:
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

    head(df2)

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

**Q**: What is untidy about this dataframe (check the meta data at
<https://data.bris.ac.uk/datasets/1vdt21e4mhxxd27hso89cqmhhh/README.txt>).

**A**:

------------------------------------------------------------------------

**Q**: Use mutate to create a new column which indicates `none` with
either 1 or 0. To do this note that `(TRUE)*1`/`(FALSE)*1 = 1`/`0`
You'll need to use
[`select`](https://dplyr.tidyverse.org/reference/select.html) to move
the new column to the left of the dataframe so you can see it easily
(see the examples at the linked page for how to do this).

**A**:

------------------------------------------------------------------------

**Q**: Now do the same for `t2_3`. The: rename `t1dili` to `t1` using
`rename` (the documentation is the same as `select`), and remove the
`pdili` variable. Note, you only need one `select` statement at the end
(i.e. don't just copy and paste from previous answers)

**A**:

------------------------------------------------------------------------

**Q**: Use [`gather`](https://tidyr.tidyverse.org/reference/gather.html)
to create a new variable called `dili` which has three different
`level`s: `none`, `t1`, `t2_3`. You'll need to use `select` again to
move it to the left hand side.

**A**:

------------------------------------------------------------------------

**Q**: What is dimension of this dataframe? Look at it (by clikcing on
the `df2_tidy` variable in the environment tab). Which values of `level`
can be dropped? Drop them using
[`filter`](https://dplyr.tidyverse.org/reference/filter.html) and then
drop the `level` column. Arrange the table in asceding values of `id`

**A**:

------------------------------------------------------------------------

Putting it together
-------------------

**Q**: We have two tidy dataframes. How many should we have?

**A**:

------------------------------------------------------------------------

**Q**: Use the [`join`](https://dplyr.tidyverse.org/reference/join.html)
function to join the two dataframes by matching on the `id` variable. It
shouldn't matter which type of join you use - *however* you should use
one that will allow you to check whether there have been data lost (or
added by not matching properly). Call the new dataframe `df_tidy`

**A**: Use the `full_join` and then check whether there are any extra
rows or columns by comparing the `dim()` on the three dataframes.

------------------------------------------------------------------------

**Q**: Now save this dataframe as a csv (`write_csv`) in the
`data/processed` directory as `dili-tidy.csv` and commit these changes
to the git repo push to the `participant` branch of your Github.

**A**:

Now knit this into the `html` notebook and then: In the home directory:

    $ git add exercises/tidy_data.Rmd
    $ git commit -m "Finished tidy data problems"
    $ git push origin master

Well done!
