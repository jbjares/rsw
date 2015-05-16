source("rJava.R")
source("javaCompileAndPackageToRFolder.R")
library(rJava)



executeAMethod <- function(){
        .jinit("MassGen-0.0.1-SNAPSHOT.jar",parameters="-Xmx512m")
        obj = .jnew(class = "com/soundwave/massgen/GeoLocationByCountryNameGen",check = TRUE)
        
        .jcall(obj = obj,returnSig = "V",method = "main", .jarray(c(
                paste0(gsub("\\\\", "/", getwd()),"/basicData.csv"),
                paste0(gsub("\\\\", "/", getwd()),"/geoLoc.csv"))))
        
}

executeAMethod()