---
title: "Getting and storing data"
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



## Overview 

1. FAIR principles
1. Storing your data and research
1. Backing up
1. Metadata
3. Tidy data
2. Retrieving data
4. File formats

---

## Your research

* Your research includes: 
  * Raw data
  * Processed data 
  * Statistical analyses and models
  * Reports, presentations, papers
* Your data will be handled slightly different but general principles apply to all of your research. 


---

## FAIR principles

https://www.nature.com/articles/sdata201618

<div class="rimage center"><img src="fig/FAIR.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="100%" class="plot" /></div>

--- &twocol

## FAIR principles
Your research should be FAIR:
*** =left

* **F**indable
  * accurate abstracts and keywords 
  * appears in search engines
  * use well known repositories
* **A**ccessible
  * open access if possible (ethics may prevent this)
  * use web interfaces and APIs
  
*** =right

* **I**nteroperable
  * Adhear to open standards, nomenclature and common syntax
  * Good documentation
  * Open source software
* **R**eusable
  * Can someone re-use your data, analysis and understand your reports?
  * Use permissable licences (e.g. CC-BY)

---

## Storing data

* You've collected your data, it can be in: 
  * Physical format e.g. paperwork, print-outs, samples. 
  * Electronic data e.g. simulation results, electronic surveys, public datasets
* If not already in electronic format you'll transcribe the results to electronic format. 
* Wherever possible, **KEEP YOUR RAW DATA**
  * Physical fomat: keep it in a box, fridge, cupboard under the stairs etc. 
  * Electronic format:
      1. Keep in a **READ ONLY** subdirectory
      2. The directory should be located on a **MANAGED STORAGE DATA** cluster (at least)

If it's just stored on your personal computer **YOU DON'T HAVE IT**


---

## Storage locations - Bristol University

* Research Data Storage Facility, [RDSF](http://www.bristol.ac.uk/acrc/research-data-storage-facility/)
  * good for long-term archiving of data
  * DOI available
  * your PI needs to apply for space
  * you can map the drive to your local machine (ask IT services for help)
  * there is a mechanism for sharing (we'll be using it later)


* [Microsoft OneDrive for Business](https://uob.sharepoint.com/sites/systemsupport/SitePages/onedrive-home.aspx)
  * good for backing up all files (not just data) and sharing with colleagues
  * personal space of 5TB
  * you can sync the drive with your local machine
  * not compatible with OSF (only personal OneDrive accounts are)


---

## Storage locations - Personal 

* [Google Drive](https://www.google.co.uk/drive/)/[Dropbox](https://www.dropbox.com/)
  * Similar to OneDrive but only ~15GB free ( ~ £80/year/TB)
  * Compatible with OSF
  
* [Figshare](https://figshare.com/)
  * Similar to RDSF
  * 5GB free
  * DOI available

* OSF has a default storage option
  * Not recommended as sole place of storage
  * Users can add-in other storage services like Figshare, Google Drive etc. 

* Many other services - please see [OSF-FAQ](http://help.osf.io/m/faqs/l/726460-faqs#what-is-the-cap-on-data-per-user-or-per-project)

---

## Backing up

* Backing up your research is **NON NEGOTIABLE**
* Redundancy is key: 
  1. Use rolling back up of whole disk using:
    * external hard drive, e.g. Time Machine for Mac, Backup and Restore for Windows 10
    * cloud storage, e.g. [Backblaze](https://www.backblaze.com/cloud-backup.html)
  2. Use OneDrive to back up all important directories
  3. Keep important research data on RDSF
  4. Back important code on Github

---

## Metadata

* Metadata = data about the data, e.g.
  * units of measurement
  * variable explanation
  * how/when/where it was collected
  * software/hardware used
  * author information (contact details)
* Should be kept in separate files but in same directory as data 
* Often called a *data dictionary*

---

## Tidy data

* Most data sets need **cleaning** before they can be used. 
* **Cleaning** involves:
  * Getting data into tables
  * Getting formats correct e.g., dates and times, units of measurement
  * Grouping observations together in meaningful ways
  * Tidying data: structuring datasets to facilitate analysis
* **Tidy data** is a set of standards for organizig data values within a dataset.
* You can read about it [here]()

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

### `tidyr` - example 1

* Scores after 50 sec, 100 sec,..., 350 sec in a game
* Q: Why isn't this tidy?


```
   Name  50 100 150 200 250 300 350
1 Carla 1.2 1.8 2.2 2.3 3.0 2.5 1.8
2  Mace 1.5 1.1 1.9 2.0 3.6 3.0 2.5
3   Lea 1.7 1.6 2.3 2.7 2.6 2.2 2.6
4 Karen 1.3 1.7 1.9 2.2 3.2 1.5 1.9
```

> - A: the columns are observations!

---

### `tidyr` - example 1

* use [`gather`](https://tidyr.tidyverse.org/reference/gather.html) to make tidy:


```r
scores %>%
  # Gather ALL columns and give default names to columns
  gather() %>%
  headtail()
```

```
    key value
1  Name Carla
2  Name  Mace
3  Name   Lea
30  350   2.5
31  350   2.6
32  350   1.9
```

---

### `tidyr` - example 1

* use [`gather`](https://tidyr.tidyverse.org/reference/gather.html) to make tidy:


```r
scores %>%
  # Gather all columns and give custom names to columns
  gather(key="MyVariable", value="MyValue") %>%
  headtail()
```

```
   MyVariable MyValue
1        Name   Carla
2        Name    Mace
3        Name     Lea
30        350     2.5
31        350     2.6
32        350     1.9
```

---

### `tidyr` - example 1

* use [`gather`](https://tidyr.tidyverse.org/reference/gather.html) to make tidy:


```r
scores %>%
  # Gather all columns except 'Name' and give custom names to columns
  gather(key="Time", value="Score", -Name) %>%
  headtail()
```

```
    Name Time Score
1  Carla   50   1.2
2   Mace   50   1.5
3    Lea   50   1.7
26  Mace  350   2.5
27   Lea  350   2.6
28 Karen  350   1.9
```

---

### `tidyr` - example 2

* Q: What's wrong with this table of counts of males (`m`) and females (`f`) of different ages (`0.15` = 0 - 15) in different states


```
  state m0-15 m16-60 f0-15 f16-60
1    MA     1      3     4      4
2    NY    10      7     9      9
3    CN     6      3    10      9
4    OH     3      3    10      7
```

> - A: Columns as variables AND multiple variables in a column

---

### `tidyr` - example 2

* First use [`gather`](https://tidyr.tidyverse.org/reference/gather.html)


```r
df %>%
  gather(key='sex-age', value='count', -state) %>%
  headtail()
```

```
   state sex-age count
1     MA   m0-15     1
2     NY   m0-15    10
3     CN   m0-15     6
14    NY  f16-60     9
15    CN  f16-60     9
16    OH  f16-60     7
```

---

### `tidyr` - example 2

* Then use  [`separate`](https://tidyr.tidyverse.org/reference/separate.html)


```r
df %>%
  gather(key='sex-age', value='count', -state) %>%
  separate(col='sex-age', into=c('sex', 'age'), sep=1) %>%
  headtail()
```

```
   state sex   age count
1     MA   m  0-15     1
2     NY   m  0-15    10
3     CN   m  0-15     6
14    NY   f 16-60     9
15    CN   f 16-60     9
16    OH   f 16-60     7
```

---

## Retrieving data

* If you've retrieved data - put a note to say where it's from:
<div class="rimage center"><img src="fig/source.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" width="75%" class="plot" /></div>

* Even better, write a script that downloads it: 

```r
library(data.table)
file_name <- 'dili_from_anti_TB_treatment.csv'
base_url <- 'http://data.bris.ac.uk/datasets/1vdt21e4mhxxd27hso89cqmhhh/'
file_url <- paste0(base_url, file_name)
df <- fread(file_url)
save(df, file='local/directory/path')
```

---

## File formats

* File formats affect interoperability and accessibility. 
* Proprietory formats for data (e.g. custom binary format) or analysis scripts lower interoperability
* For small, simple data text based formats work well e.g. `.csv`
* For structured data use [`XML`](https://www.w3schools.com/xml/xml_whatis.asp) or  [`json`](https://www.json.org/) or database format e.g. [`mySQL`](https://www.mysql.com/)
* For large data sets use things like [`HDF5`](https://support.hdfgroup.org/HDF5/) which are usable without loading into memory. 

