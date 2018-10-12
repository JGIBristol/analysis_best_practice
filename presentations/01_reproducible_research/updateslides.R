#Create slides
library(slidify)
current_path = rstudioapi::getActiveDocumentContext()$path 
setwd(dirname(current_path))
fn1 <- "index.html"
fn2 <- "index.md"
if (file.exists(fn1)) file.remove(fn1)
if (file.exists(fn2)) file.remove(fn2)
slidify("index.Rmd")


