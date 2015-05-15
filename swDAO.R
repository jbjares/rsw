
source("global.R")
library(ggplot2)
library(reshape)
library(plyr)
library(rmongodb)
library(dplyr)

findAllObsUnderPlayCollection <- function(){
  cursor <- mongo.find.all(mongoConn, playCollectionVar, query = mongo.bson.empty(), sort = mongo.bson.empty(),
                           fields = mongo.bson.empty(), limit = 0L, skip = 0L, options = 0L,data.frame = F)
  return(cursor)  
}

convertCursorToDataFrame <- function(){
  cursor <- findAllObsUnderPlayCollection()
  globalDF <- data.frame(matrix(unlist(cursor), nrow=386, byrow=T),stringsAsFactors=FALSE)
  colnames(globalDF) <- c("ID","COL_NAME","PLAY_DATE","TITLE","ARTIST","ACCESS_DATE","PLATAFORM","SOURCE_NAME","DEVICE","BACKGROUNDED","AUTOPLAY","LNG","LAT","COUNTRY","USER_ID","ACTION_TYPE")
  return(globalDF)
}

##Example
subsetBySourceNameVectorAndLngLat<- function(){
  df <- convertCursorToDataFrame()
  subset <- df %>%
    select(PLAY_DATE,SOURCE_NAME,LNG,LAT) %>%
    filter(SOURCE_NAME!="ANDROID" & LNG=="-64.639968" & LAT=="18.420695") %>%
    arrange(desc(PLAY_DATE)) %>%
    mutate(PLAY_DATE = as.Date(PLAY_DATE)) %>%
    mutate(PLAY_COUNT_RDIO = ifelse(SOURCE_NAME=="RDIO", sum(SOURCE_NAME=="RDIO"),0),
           PLAY_COUNT_PLAYER_PRO = ifelse(SOURCE_NAME=="PLAYER_PRO", sum(SOURCE_NAME=="PLAYER_PRO"),0),
           PLAY_COUNT_YOUTUBE = ifelse(SOURCE_NAME=="YOUTUBE", sum(SOURCE_NAME=="YOUTUBE"),0))
  
  #View(subset)
}

##Example
plotGraphicBasedOnGivenDates <- function(){
  r=runif(length(convertDate()))
  d <- convertDate()
  plot(d,r,type="l",xaxt="n")
  axis.Date(1, d, format="%m/%d/%Y")
}

plotGraphicBasedOnGivenDates <- function(){
  r=runif(length(convertDate()))
  d <- convertDate()
  plot(d,r,type="l",xaxt="n")
  axis.Date(1, d, format="%m/%d/%Y")
}

##Example
convertDate <- function(){
  df <- convertCursorToDataFrame()
  subset <- df %>%
    select(PLAY_DATE,SOURCE_NAME,LNG,LAT) %>%
    filter(SOURCE_NAME!="ANDROID" & LNG=="-64.639968" & LAT=="18.420695") %>%
    arrange(desc(PLAY_DATE)) %>%
    mutate(PLAY_DATE = as.Date(PLAY_DATE))
  #summarise(COUNT = sum(SOURCE_NAME!="ANDROID"))
  dateList <- lapply(as.list(subset$PLAY_DATE),as.Date);
  result <- list(dateList, dateList)
  (result <- do.call("c", dateList))
  return(result)
}

plotGraphicBasedOnGivenDates()