library(rJava)
compileAndPackagejavaToRFolder <- function(
        
        #TODO insert an inputdata to end-user set the java-project-path
        massgenFolder="C:/Users/JoaoBoscoJares/workspace/soundwave/MassGen/"){
        rProjectMainFolder <- getwd()
        cat(rProjectMainFolder)
        setwd(massgenFolder)
        cat(getwd())
        #system("mvn install -Dmaven.test.skip=true",show.output.on.console = TRUE)
        system("mvn clean dependency:copy-dependencies package",show.output.on.console = TRUE)
        
        DirSource <- paste0(getwd(),"/","target/","dependency")
        DirEnd <- paste0(rProjectMainFolder)
        system(paste("cp -r", DirSource, DirEnd))
        
        file.copy(paste0(getwd(),"/","target/","MassGen-0.0.1-SNAPSHOT.jar"), 
                  paste0(rProjectMainFolder))
 
        setwd(rProjectMainFolder)
}

compileAndPackagejavaToRFolder()