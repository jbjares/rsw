
source("global.R")
library(ggplot2)
library(reshape)
library(plyr)
library(rmongodb)
library(dplyr)
library(rpart)

findAllObsUnderPlayCollection <- function(){
  cursor <- mongo.find.all(mongoConn, playCollectionVar, query = mongo.bson.empty(), sort = mongo.bson.empty(),
                           fields = mongo.bson.empty(), limit = 0L, skip = 0L, options = 0L,data.frame = F)
  return(cursor)  
}

retrieveMainDF <- function(){
  cursor <- findAllObsUnderPlayCollection()
  globalDF <- data.frame(matrix(unlist(cursor), nrow=386, byrow=T),stringsAsFactors=FALSE)
  colnames(globalDF) <- c("ID","COL_NAME","PLAY_DATE","TITLE","ARTIST","ACCESS_DATE","PLATAFORM","SOURCE_NAME","DEVICE","BACKGROUNDED","AUTOPLAY","LNG","LAT","COUNTRY","USER_ID","ACTION_TYPE")
  
  subset <- globalDF %>%
    select(ID,COL_NAME,PLAY_DATE,TITLE,ARTIST,ACCESS_DATE,PLATAFORM,SOURCE_NAME,DEVICE,BACKGROUNDED,AUTOPLAY,LNG,LAT,COUNTRY,USER_ID,ACTION_TYPE) %>%
    arrange(desc(PLAY_DATE)) %>%
    mutate(PLAY_DATE = as.Date(PLAY_DATE)) %>%
    mutate(PLAY_COUNT_RDIO = ifelse(SOURCE_NAME=="RDIO", sum(SOURCE_NAME=="RDIO"),0),
           PLAY_COUNT_PLAYER_PRO = ifelse(SOURCE_NAME=="PLAYER_PRO", sum(SOURCE_NAME=="PLAYER_PRO"),0),
           PLAY_COUNT_YOUTUBE = ifelse(SOURCE_NAME=="YOUTUBE", sum(SOURCE_NAME=="YOUTUBE"),0),
           PLAY_COUNT_SPOTIFY = ifelse(SOURCE_NAME=="SPOTIFY", sum(SOURCE_NAME=="SPOTIFY"),0),
           PLAY_COUNT_SOUNDCLOUD = ifelse(SOURCE_NAME=="SOUNDCLOUD", sum(SOURCE_NAME=="SOUNDCLOUD"),0),
           PLAY_COUNT_DEEZER = ifelse(SOURCE_NAME=="DEEZER", sum(SOURCE_NAME=="DEEZER"),0),
           PLAY_COUNT_WINAMP = ifelse(SOURCE_NAME=="WINAMP", sum(SOURCE_NAME=="WINAMP"),0),
           PLAY_COUNT_AMAZONMUSIC = ifelse(SOURCE_NAME=="AMAZONMUSIC", sum(SOURCE_NAME=="AMAZONMUSIC"),0),
           PLAY_COUNT_TIDALLOSSLESSAUDIO = ifelse(SOURCE_NAME=="TIDALLOSSLESSAUDIO", sum(SOURCE_NAME=="TIDALLOSSLESSAUDIO"),0),
           PLAY_COUNT_ANDROID = ifelse(SOURCE_NAME=="ANDROID", sum(SOURCE_NAME=="ANDROID"),0))
  
  return(subset)
}

##Example
retrieveAllAndroids <- function(){
  df <- retrieveMainDF()
  subset <- df %>%
    select(PLAY_DATE,SOURCE_NAME) %>%
    #filter(SOURCE_NAME!="ANDROID" & LNG=="-64.639968" & LAT=="18.420695") %>%
    filter(SOURCE_NAME=="ANDROID") %>%
    arrange(desc(PLAY_DATE)) %>%
    mutate(PLAY_DATE = as.Date(PLAY_DATE)) %>%
    mutate(PLAY_COUNT_ANDROID = ifelse(SOURCE_NAME=="ANDROID", sum(SOURCE_NAME=="ANDROID"),0))
  return(subset)
  #View(subset)
}

##Example
retrieveAllNonAndroids <- function(){
  df <- retrieveMainDF()
  subset <- df %>%
    select(PLAY_DATE,SOURCE_NAME) %>%
    #filter(SOURCE_NAME!="ANDROID" & LNG=="-64.639968" & LAT=="18.420695") %>%
    filter(SOURCE_NAME!="ANDROID") %>%
    arrange(desc(PLAY_DATE)) %>%
    mutate(PLAY_DATE = as.Date(PLAY_DATE)) %>%
    mutate(PLAY_COUNT_RDIO = ifelse(SOURCE_NAME=="RDIO", sum(SOURCE_NAME=="RDIO"),0),
           PLAY_COUNT_PLAYER_PRO = ifelse(SOURCE_NAME=="PLAYER_PRO", sum(SOURCE_NAME=="PLAYER_PRO"),0),
           PLAY_COUNT_YOUTUBE = ifelse(SOURCE_NAME=="YOUTUBE", sum(SOURCE_NAME=="YOUTUBE"),0),
           PLAY_COUNT_SPOTIFY = ifelse(SOURCE_NAME=="SPOTIFY", sum(SOURCE_NAME=="SPOTIFY"),0),
           PLAY_COUNT_SOUNDCLOUD = ifelse(SOURCE_NAME=="SOUNDCLOUD", sum(SOURCE_NAME=="SOUNDCLOUD"),0),
           PLAY_COUNT_DEEZER = ifelse(SOURCE_NAME=="DEEZER", sum(SOURCE_NAME=="DEEZER"),0),
           PLAY_COUNT_WINAMP = ifelse(SOURCE_NAME=="WINAMP", sum(SOURCE_NAME=="WINAMP"),0),
           PLAY_COUNT_AMAZONMUSIC = ifelse(SOURCE_NAME=="AMAZONMUSIC", sum(SOURCE_NAME=="AMAZONMUSIC"),0),
           PLAY_COUNT_TIDALLOSSLESSAUDIO = ifelse(SOURCE_NAME=="TIDALLOSSLESSAUDIO", sum(SOURCE_NAME=="TIDALLOSSLESSAUDIO"),0))
  return(subset)
  #View(subset)
}

##Example
retrievePlayDatesForRdio <- function(){
  df <- retrieveMainDF()
  subset <- df %>%
    select(PLAY_DATE,SOURCE_NAME) %>%
    filter(SOURCE_NAME=="RDIO") %>%
    arrange(desc(PLAY_DATE)) %>%
    mutate(PLAY_DATE = as.Date(PLAY_DATE)) %>%
    return(subset)
}

##Example
plotGraphicBasedOnGivenDates <- function(){
  print(convertDate())
  print(class(convertDate()))
  r=runif(length(convertDate()))
  d <- convertDate()
  plot(d,r,type="l",xaxt="n")
  axis.Date(1, d, format="%m/%d/%Y")
}

##Example
plotGraphicBasedOnGivenDates2 <- function(){
  d <- retrieveAllDatesBySourceName("RDIO")
  r <- sum(subsetBySourceNameVectorAndLngLat()$SOURCE_NAME=="RDIO")
  r=runif(length(d))
  plot(d,r,type="l",xaxt="n")
  axis.Date(1, d, format="%m/%d/%Y")
}


##Example
plotGraphicBasedOnGivenDates3 <- function(){
  test_data <- retrieveMainDF()
  PLAY_DATE <- retrieveMainDF()$PLAY_DATE
  
  PLAY_COUNT_RDIO <- retrieveMainDF()["PLAY_COUNT_RDIO"]
  PLAY_COUNT_PLAYER_PRO <- retrieveMainDF()["PLAY_COUNT_PLAYER_PRO"]
  PLAY_COUNT_SPOTIFY <- retrieveMainDF()["PLAY_COUNT_SPOTIFY"]
  PLAY_COUNT_YOUTUBE <- retrieveMainDF()["PLAY_COUNT_YOUTUBE"]
  PLAY_COUNT_SOUNDCLOUD <- retrieveMainDF()["PLAY_COUNT_SOUNDCLOUD"]
  PLAY_COUNT_DEEZER <- retrieveMainDF()["PLAY_COUNT_DEEZER"]
  PLAY_COUNT_WINAMP <- retrieveMainDF()["PLAY_COUNT_WINAMP"]
  PLAY_COUNT_AMAZONMUSIC <- retrieveMainDF()["PLAY_COUNT_AMAZONMUSIC"]
  PLAY_COUNT_TIDALLOSSLESSAUDIO <- retrieveMainDF()["PLAY_COUNT_TIDALLOSSLESSAUDIO"]
  
  nonAndroidPlayersSum <- sum(PLAY_COUNT_RDIO,
                              PLAY_COUNT_PLAYER_PRO,PLAY_COUNT_SPOTIFY,
                              PLAY_COUNT_YOUTUBE,PLAY_COUNT_SOUNDCLOUD,
                              PLAY_COUNT_DEEZER,PLAY_COUNT_WINAMP,
                              PLAY_COUNT_AMAZONMUSIC,PLAY_COUNT_TIDALLOSSLESSAUDIO)
  androidPlayersSum <- sum(retrieveMainDF()["PLAY_COUNT_ANDROID"])
  
  coeflm <- coef(lm(nonAndroidPlayersSum ~ androidPlayersSum, data = retrieveMainDF()))
  
  print(coeflm)
  
  p <- ggplot(test_data, aes(PLAY_DATE)) + 
    geom_line(aes(y = PLAY_COUNT_RDIO, colour = "PLAY_COUNT_RDIO")) + 
    geom_line(aes(y = PLAY_COUNT_PLAYER_PRO, colour = "PLAY_COUNT_PLAYER_PRO"))+
    geom_line(aes(y = PLAY_COUNT_YOUTUBE, colour = "PLAY_COUNT_YOUTUBE"))+
    geom_line(aes(y = PLAY_COUNT_SOUNDCLOUD, colour = "PLAY_COUNT_SOUNDCLOUD"))+
    geom_line(aes(y = PLAY_COUNT_DEEZER, colour = "PLAY_COUNT_DEEZER"))+
    geom_line(aes(y = PLAY_COUNT_WINAMP, colour = "PLAY_COUNT_WINAMP"))+
    geom_line(aes(y = PLAY_COUNT_AMAZONMUSIC, colour = "PLAY_COUNT_AMAZONMUSIC"))+
    geom_line(aes(y = PLAY_COUNT_TIDALLOSSLESSAUDIO, colour = "PLAY_COUNT_TIDALLOSSLESSAUDIO"))
  
  print(p)
}


##Example
retrieveAllDatesBySourceName <- function(sourceName){
  df <- retrieveMainDF()
  subset <- df %>%
    select(PLAY_DATE,SOURCE_NAME,LNG,LAT) %>%
    filter(SOURCE_NAME==sourceName) %>%
    arrange(desc(PLAY_DATE)) %>%
    mutate(PLAY_DATE = as.Date(PLAY_DATE))
  dateList <- lapply(as.list(subset$PLAY_DATE),as.Date);
  result <- list(dateList, dateList)
  (result <- do.call("c", dateList))
  print(result)
  return(result)
}

##Example
convertDate <- function(){
  df <- retrieveMainDF()
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

plotGraphicBasedOnGivenDates3()
#retrieveAllDatesBySourceName("RDIO")
#count(retrieveAllDatesBySourceName("RDIO"))