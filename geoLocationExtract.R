source("global.R")
library(rJava)



executeAMethod <- function(){
        if(!is.null(jp)){
          .jinit("MassGen-0.0.1-SNAPSHOT.jar",parameters="-DrJava.debug=true -Xmx512m")
          .jengine(start = T, silent = F)
          .jpackage(paste0(gsub("\\\\", "/", getwd()),"/lib"), jars='*', , nativeLibrary=F, lib.loc=NULL)
          
        }
        obj <- .jnew(class = "com/soundwave/massgen/GeoLocationByCountryNameGen",check = TRUE)         
        .jcall(obj = obj,returnSig = "V",method = "main", .jarray(c(
                paste0(gsub("\\\\", "/", getwd()),"/basicData.csv"),
                paste0(gsub("\\\\", "/", getwd()),"/geoLoc.csv"))))
        
}

executeAMethod()