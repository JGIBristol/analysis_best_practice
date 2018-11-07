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

## Retrieving data

* If you've retrieved data - put a note to say where it's from:
<div class="rimage center"><img src="fig/source.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="75%" class="plot" /></div>

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

