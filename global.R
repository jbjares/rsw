playCollectionVar <- "soundwave.Play"
hostDesenv <- "127.0.0.1"
usernameDesenv <-""
passwordDesenv <- ""
dbDesenv = "soundwave"
seed <<- 123

fullDFColumnsNames <<- c("ID","COL_NAME","PLAY_DATE","TITLE","ARTIST","ACCESS_DATE","PLATAFORM","SOURCE_NAME","DEVICE","BACKGROUNDED","AUTOPLAY","LNG","LAT","COUNTRY","USER_ID","ACTION_TYPE")

if(!exists("mongoConn")){
    mongoConn <<- NULL
}
if(!exists("cursor")){
    cursor <<- NULL
}

if(!exists("fullDF")){
    fullDF <<- NULL
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
  if(!("lubridate" %in% rownames(installed.packages()))){
    install.packages("lubridate")
  }
  if(!("stringr" %in% rownames(installed.packages()))){
    install.packages("stringr")
  }
  
}



installRequiredPackages()
connectWithMongo()