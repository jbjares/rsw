source("rJava.R")
source("global.R")
library(rJava)

compileAndPackagejavaToRFolder <- function(massgenFolder){
  projectHome <- readline("Please, inform the cloned project location:")
  if(projectHome==""){
    cat("You didn't set the folder of your cloned repository properly. The system will set the default one (developer's machine dependent).")
    massgenFolder <- "C:/Users/JoaoBoscoJares/workspace/soundwave/MassGen/"  
  }else{
    massgenFolder <- projectHome
  }
  
  rProjectMainFolder <- getwd()
  setwd(massgenFolder)
  
  system("mvn eclipse:eclipse",show.output.on.console = TRUE)
  system("mvn install -Dmaven.test.skip=true",show.output.on.console = TRUE)
  system("mvn clean dependency:copy-dependencies package -Dmaven.test.skip=true",show.output.on.console = TRUE)
  
  if(file.exists("MassGen-0.0.1-SNAPSHOT.jar")){
    file.remove("MassGen-0.0.1-SNAPSHOT.jar")
  }
  file.copy(paste0(getwd(),"/","target/","MassGen-0.0.1-SNAPSHOT.jar"), 
            paste0(rProjectMainFolder),overwrite = TRUE)
  
  if(!file.exists(paste0(rProjectMainFolder,"/","lib"))){
    dir.create(paste0(rProjectMainFolder,"/","lib"),
               showWarnings = TRUE, recursive = FALSE)
  }
  
  DirSource <- paste0(getwd(),"/","target/","dependency/*.*")
  DirEnd <- paste0(rProjectMainFolder,"/","lib/")
  file.copy( paste0(getwd(),"/","target/","dependency"),
             paste0(rProjectMainFolder,"/","lib"), overwrite = TRUE)
  system(paste("cp -r", DirSource, DirEnd))
  
  setwd(rProjectMainFolder)
  
 
}

compileAndPackagejavaToRFolder()