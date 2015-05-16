source("rJava.R")
source("javaCompileAndPackageToRFolder.R")
library(rJava)



executeAMethod <- function(){
        .jinit("MassGen-0.0.1-SNAPSHOT.jar",parameters="-Xmx512m")
        obj = .jnew(class = "com/soundwave/massgen/ITunesSalesDataGen",check = TRUE)
        
        .jcall(obj = obj,returnSig = "V",method = "main", .jarray(c(
                paste0(gsub("\\\\", "/", getwd()),"/iTunesCodesAndCountries.csv"),
                paste0(gsub("\\\\", "/", getwd()),"/basicData.csv"))))
        
}

executeAMethod()