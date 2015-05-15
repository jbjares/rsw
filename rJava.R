#TODO insert an inputdata to end-user set the JAVA_HOME path
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk1.7.0_71/jre")

if(!("rJava" %in% rownames(installed.packages()))){
        install.packages("rJava")  
}

library(rJava)