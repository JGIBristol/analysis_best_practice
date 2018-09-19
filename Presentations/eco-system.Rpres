Your data analysis ecosystem
========================================================
author: Robert Arbon
date: 
autosize: true

Overview
========================================================
1. Our example analysis project
1. The analysis pipeline
2. Storing data
3. Version control

Our project
========================================================

* Abbara et. al. *Drug-induced liver injury from antituberculous treatment: a retrospective study from a large TB centre in the UK*, BMC Infectious Diseases, 2017.
* Goal: reproduce the table opposite. 

***

![table3](eco-system-figure/table3.png)

Analysis pipeline
========================================================

1. Data
2. Tidy and clean data
3. Exploratory data analysis
4. Model building
5. Report writing
6. Sharing results

Data
========================================================

![original data location](eco-system-figure/file-system-original.png)

* *dili_from...tment.csv*: raw data - no metadata. 
* *README.txt*: the metadata
* *source.txt*: where/how the data was collected


Raw data
========================================================

![raw data](eco-system-figure/raw-data.png)

* *Tidy* - more on this later - but generally: 
  * Each row is an *observation*
  * Each column is *variable*
  * Single row of column headers
  * No blank rows or columns (blank fields are fine)

Metadata
========================================================

![raw data](eco-system-figure/readme.png)

* Explanation of project and data  
* Headers/variables explained
* Units and variable type (categorical/ordinal/integer/float)

Sources
========================================================

![source file](eco-system-figure/source.png)

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




