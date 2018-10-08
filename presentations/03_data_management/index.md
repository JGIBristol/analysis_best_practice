---
title: "Data analysis best practice"
author: "Robert Arbon"
highlighter: highlight.js
hitheme: tomorrow
job: Data scientist, Jean Golding Institute
logo: bloomberg_shield.png
mode: selfcontained
subtitle: Data management
framework: io2012
url:
  assets: ../assets
  lib: ../librariesNew
widgets: mathjax
---




## Overview 

1. Storing data
2. Retrieving data
3. Tidy data
4. File formats


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

If it's just stored on your laptop **YOU DON'T HAVE IT**

---

## Storage locations - Bristol University

* Research Data Storage Facility, [RDSF](http://www.bristol.ac.uk/acrc/research-data-storage-facility/)
  * good for long-term archiving
  * DOI available
  * your PI needs to apply for space
  * you can map the drive to your local machine (ask IT services for help)
  * there is a mechanism for sharing (we'll be using it later)


* [Microsoft OneDrive for Business](https://uob.sharepoint.com/sites/systemsupport/SitePages/onedrive-home.aspx)
  * good for backing up files and sharing with colleagues
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

## Storage locations - Open Science Foundation




---

## Backing up

* Backing up your data is **NON NEGOTIABLE**
* Redundancy is key: 
  1. Use rolling back up with external hard drive: 
      e.g. Time Machine for Mac, Backup and Restore for Windows 10
  2. Use OneDrive to back up all important directories
  3. Keep important research data on RDSF
  4. Back important code on Github
  
  
---

