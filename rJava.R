
javaHomeVar <- readline("If you know where's located your JAVA_HOME, please set. Else just input 'N'? \n (e.g C:/Program Files/Java/jdk1.7.0_71/jre)") 
if(javaHomeVar=="N"){
  javaHomeVar <- readline(
    "Can I set to the following location C:/Program Files/Java/jdk1.7.0_71/jre ? (Y/N)") 
}
if(javaHomeVar=="Y"){
  Sys.setenv(JAVA_HOME=paste0(gsub("\\\\", "/", javaHomeVar)))
}
if(javaHomeVar==""){
  print("Quitting app...")
  q()
}

print("Thank you!")

if(!("rJava" %in% rownames(installed.packages()))){
  install.packages("rJava")  
}
