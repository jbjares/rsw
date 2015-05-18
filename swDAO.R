
source("global.R")
source("Util.R")
library(ggplot2)
library(reshape)
library(plyr)
library(rmongodb)
library(dplyr)



DAO <- list(
  
  
    findAllObsUnderPlayCollection = function(){
      cursor <- mongo.find.all(mongoConn, playCollectionVar, query = mongo.bson.empty(), sort = mongo.bson.empty(),
                               fields = mongo.bson.empty(), limit = 0L, skip = 0L, options = 0L,data.frame = F)
      return(cursor)  
    },
    
    convertCursorToDataFrame = function(cursorIn){
      cursor <- cursorIn
      cursor <- data.frame(matrix(unlist(cursor), nrow=length(cursorIn), byrow=T),stringsAsFactors=FALSE)
      colnames(cursor) <- fullDFColumnsNames
      return(cursor)
    },

    
    ##Example
    subsetDatesAndServiceNameByServiceName = function(fullDF,serviceName){
      subset <- fullDF %>%
        select(PLAY_DATE,SOURCE_NAME)  %>%
        arrange(desc(PLAY_DATE)) %>%
        mutate(x = Util$convertDate((PLAY_DATE))) %>%
        mutate(y = ifelse(SOURCE_NAME==serviceName, Util$convertDate(PLAY_DATE),0))
      return(subset)
    },
    
    ##Example
    subsetBySourceNameVectorAndLngLat = function(){
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
    },
    
    aggregateDateAndCountryOfAcessByServiceName = function(fullDF,serviceName){
      dates <- ymd_hms(fullDF$PLAY_DATE)
      countries <- fullDF$COUNTRY
      pp_values <- ifelse(fullDF$SOURCE_NAME==serviceName, sum(fullDF$SOURCE_NAME==serviceName),0)
      aggregate <- aggregate(pp_values ~ dates + countries, data=fullDF, FUN=sum)
      aggregate$share <- ave(aggregate$pp_values, aggregate$countries, aggregate$dates, FUN=function(x) x/sum(x))
      aggregate <- na.omit(aggregate)
      return(aggregate)
    },
    ## expect the result of the: aggregateDateAndCountryOfAcessByServiceName
    summarizeAAccessPerCountry = function(aggregateDateAndCountryOfAcessByServiceName){
      result <- ddply(aggregateDateAndCountryOfAcessByServiceName, .(countries), summarize, total_sare = sum(share))
      return(result)
    },
    
    ##Example
    plotGraphicBasedOnGivenDates = function(){
      r=runif(length(convertDate()))
      d <- convertDate()
      plot(d,r,type="l",xaxt="n")
      axis.Date(1, d, format="%m/%d/%Y")
    },
    
    plotGraphicBasedOnGivenDates <- function(){
      r=runif(length(convertDate()))
      d <- convertDate()
      plot(d,r,type="l",xaxt="n")
      axis.Date(1, d, format="%m/%d/%Y")
    },
    
    ##Example
    convertDate = function(){
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
)

if(is.null(cursor) | is.null(fullDF)){
  cursor<<- DAO$findAllObsUnderPlayCollection()
  fullDF<<- DAO$convertCursorToDataFrame(cursor)  
}