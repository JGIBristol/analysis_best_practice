Data management
========================================================
author: Robert Arbon
date: 
autosize: true

Overview
========================================================
1. Storing data
2. Retrieving data
3. Tidy data
4. File formats


Storing data
========================================================

* You've collected your data, it can be in: 
  * Physical format e.g. paperwork, print-outs, samples. 
  * Electronic data e.g. simulation results, electronic surveys, public datasets
* Wherever possible, **KEEP YUR RAW DATA**
  * Physical fomat: keep it in a box, fridge, cupboard under the stairs etc. 
  * Electronic format:
      1. Keep in a **READ ONLY** subdirectory
      2. The directory should be located on a **MANAGED STORAGE DATA** cluster (at least)

If it's just stored on your laptop **YOU DON'T HAVE IT**
      


Data
========================================================

![original data location](getting-data-figure/file-system-original.png)

* *dili_from...tment.csv*: raw data - no metadata. 
* *README.txt*: the metadata
* *source.txt*: where/how the data was collected


Raw data
========================================================

![raw data](getting-data-figure/raw-data.png)

* *Tidy* - more on this later - but generally: 
  * Each row is an *observation*
  * Each column is *variable*
  * Single row of column headers
  * No blank rows or columns (blank fields are fine)

Metadata
========================================================

![raw data](getting-data-figure/readme.png)

* Explanation of project and data  
* Headers/variables explained
* Units and variable type (categorical/ordinal/integer/float)

Sources
========================================================

![source file](getting-data-figure/source.png)

* Optional: depends on how/where the data was recorded. 
* Notes location of permanent store of data and how to download it. 
* Could be a script to automatically download data from public source. 

Exercise
========================================================


1. Create a project folder with the following structure: 

  ```
  dili
      /data
          /original
  ```

2. Download data from https://data.bris.ac.uk by searching for "Drug induced liver injury"

3. Place data, metadata in the `original` folder 
4. Create a text file to describe how and when you downloaded the data. 
5. Make the folder read only

Tidying and cleaning data
========================================================

First get data into a *dataframe*:


```r
df <- read.csv('../data/original/dili_from_anti_TB_treatment.csv')
head(df)
```

```
  id pdili t1dili agegroup sex weight rifam_dpw ison_dpw pyraz_dpw
1  1     1      1    30/39   F   67.0  8.955224 4.477612  22.38806
2  2     1      1    30/39   F   51.6 11.627907 5.813953  29.06977
3  3     1      0    30/39   M   63.1  9.508717 4.754358  15.84786
4  4     1      1      40+   M   83.0  7.228916 3.614458  18.07229
5  5     1      1      40+   F   76.2  7.874016 3.937008  26.24672
6  6     1      1    18/29   M   55.0 10.909091 5.454546  27.27273
  moxi_dpw hiv hcv hbv alcohol liver_disease tb_site log10base_alt
1       NA   0   0   0       0             0       2      1.462398
2       NA   0  NA  NA       0             0       2      0.698970
3       NA   0   1   0      NA             1       1      1.146128
4 4.819277   0   0   0       1             0       2      1.491362
5 5.249344   0   0   0      NA             0       2      1.204120
6       NA   0   0   0       0             0       1      1.724276
  log10base_alp log10base_bili time_to_onset_of_pDILI
1      1.740363      1.0000000                     55
2      1.799341      0.7781513                      8
3      2.000000      0.6989700                     50
4      1.792392      1.1139433                     91
5      1.897627      0.9030900                     14
6      1.491362      1.1139433                      2
```

