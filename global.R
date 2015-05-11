source("mongo.R")

installRequiredPackages <- function(){
  if(!("rmongodb" %in% rownames(installed.packages()))){
    install.packages("rmongodb")  
  }
  if(!("plyr" %in% rownames(installed.packages()))){
    install.packages("plyr")  
  }
  if(!("ggplot2" %in% rownames(installed.packages()))){
    install.packages("ggplot2")  
  }
  if(!("reshape2" %in% rownames(installed.packages()))){
    install.packages("reshape2")  
  }
  if(!("dplyr" %in% rownames(installed.packages()))){
    install.packages("dplyr")  
  }
}



installRequiredPackages()
