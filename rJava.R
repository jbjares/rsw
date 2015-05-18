
javaHomeVar <- readline(
  "If your JAVA_HOME is different from that \n
  C:/Program Files/Java/jdk1.7.0_71/jre, please input below, else press enter:")

if(javaHomeVar!=""){
  Sys.setenv(JAVA_HOME=javaHomeVar)
}else{
  Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk1.7.0_71/jre")
  javaHomeVar<- "C:/Program Files/Java/jdk1.7.0_71/jre"
}


if(!("rJava" %in% rownames(installed.packages()))){
        install.packages("rJava")  
}

library(rJava)
.jinit("MassGen-0.0.1-SNAPSHOT.jar",parameters="-DrJava.debug=true -Xmx512m")
jp <- getOption("java.parameters")
while(is.null(jp)){
  jp <- getOption("java.parameters")
}

.jengine(start = T, silent = F)
.jpackage(paste0(gsub("\\\\", "/", getwd()),"/lib"), jars='*', , nativeLibrary=F, lib.loc=NULL)