playCollectionVar <- "soundwave.Play"
hostDesenv <- "127.0.0.1"
usernameDesenv <-""
passwordDesenv <- ""
dbDesenv = "soundwave"


if(!exists("mongoConn")){
  mongoConn <- NULL
}

connectWithMongo <- function(){
  library(rmongodb)
  mongoConn <<- mongo.create(host = hostDesenv, username = usernameDesenv, password = passwordDesenv, db = dbDesenv, timeout = 0L)
}

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
  if(!("rpart" %in% rownames(installed.packages()))){
    install.packages("rpart")
  }
  
}



installRequiredPackages()
connectWithMongo()