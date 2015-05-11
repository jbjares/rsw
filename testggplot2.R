
source("global.R")


library(ggplot2)
library(reshape)
library(plyr)
library(rmongodb)
library(dplyr)

mongo <- mongo.create(host = hostDesenv, username = usernameDesenv, password = passwordDesenv, db = dbDesenv, timeout = 0L)
cursor <- mongo.find.all(mongo, playCollectionVar, query = mongo.bson.empty(), sort = mongo.bson.empty(),
                         fields = mongo.bson.empty(), limit = 0L, skip = 0L, options = 0L,data.frame = F)

df <- data.frame(matrix(unlist(cursor), nrow=386, byrow=T),stringsAsFactors=FALSE)
colnames(df) <- c("ID","COL_NAME","PLAY_DATE","TITLE","ARTIST","ACCESS_DATE","PLATAFORM","SOURCE_NAME","DEVICE","BACKGROUNDED","AUTOPLAY","LNG","LAT","COUNTRY","USER_ID","ACTION_TYPE")

Count <- rle(sort(df$SOURCE_NAME))
x <- Count$values
y <- Count$lengths
df2<-data.frame(x=x,y=y)
par(mfcol=c(1,2))

a <- ggplot(melt(x,id.vars=y),aes(x,Count$lengths,colour=Count$values,group="goups"))+ geom_line()


b <- ggplot(melt(x,id.vars=y),aes(x,Count$lengths,colour=Count$values,group=Count$values))+
geom_bar(subset=.(y=="y"),stat="identity")


pie(y,labels=paste0(x,": ",signif((y/sum(y))*100,5),"%"))


print(a)
print(b)