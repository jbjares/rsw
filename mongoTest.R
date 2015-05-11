
playCollectionVar <- "soundwave.Play"
hostDesenv <- "127.0.0.1"
usernameDesenv <-""
passwordDesenv <- ""
dbDesenv = "soundwave"

xValues <- NULL
yValues <- NULL
zValues <- NULL
df <- NULL
androidData <- NULL
streamdata <- NULL
testData <- NULL
library(rmongodb)
library(dplyr)
exe <- function(){
  
  mongo <- mongo.create(host = hostDesenv, username = usernameDesenv, password = passwordDesenv, db = dbDesenv, timeout = 0L)
  
  
  cursor <- mongo.find.all(mongo, playCollectionVar, query = mongo.bson.empty(), sort = mongo.bson.empty(),
                    fields = mongo.bson.empty(), limit = 0L, skip = 0L, options = 0L,data.frame = F)

  df <<- data.frame(matrix(unlist(cursor), nrow=386, byrow=T),stringsAsFactors=FALSE)
  colnames(df) <<- c("ID","COL_NAME","PLAY_DATE","TITLE","ARTIST","ACCESS_DATE","PLATAFORM","SOURCE_NAME","DEVICE","BACKGROUNDED","AUTOPLAY","LNG","LAT","COUNTRY","USER_ID","ACTION_TYPE")
  
  androidData <<- df %>%
    group_by(PLAY_DATE, SOURCE_NAME) %>%
    select(PLAY_DATE,SOURCE_NAME,LNG,LAT) %>%
    filter(SOURCE_NAME!="ANDROID" & LNG=="-64.639968" & LAT=="18.420695") %>%
    arrange(desc(PLAY_DATE))
# 
#  streamdata <<- df %>%
#    group_by(PLAY_DATE, SOURCE_NAME) %>%
#    select(PLAY_DATE,SOURCE_NAME) %>%
#    filter(SOURCE_NAME=="ANDROID") %>%
#    arrange(desc(PLAY_DATE))
#  
#  testData<<- df %>%
#    group_by(SOURCE_NAME) %>%
#    summarise(total = sum(unlist(SOURCE_NAME)),freq = n())
#   
    
}

exe()