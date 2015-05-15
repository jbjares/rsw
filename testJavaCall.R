source("rJava.R")
library(rJava)




executeAMethod <- function(){
        wd <- gsub("\\\\", "/", getwd())
        print(wd)
        
        dependencies <- list.files(paste0(wd,"/dependency"))
        print(dependencies)
        
        .jinit(classpath="MassGen-0.0.1-SNAPSHOT.jar", parameters="-Xmx512m")
        .jaddClassPath(path = paste0("./dependency/",dependencies, collapse = " "))
        
        obj<- .jnew("com/soundwave/massgen/ITunesSalesDataGen")
        result = .jcall(obj,,"gen",
        .jarray(c(paste0(wd,"/iTunesCodesAndCountries.csv")
                 ,paste0(wd,"/dependency/result.csv"))))
}

executeAMethod()