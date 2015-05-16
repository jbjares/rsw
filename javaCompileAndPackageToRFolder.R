library(rJava)
#source("gitRemotePull.R")

compileAndPackagejavaToRFolder <- function(massgenFolder){
        massgenFolder <- "C:/Users/JoaoBoscoJares/workspace/soundwave/MassGen/"
        rProjectMainFolder <- getwd()
        setwd(massgenFolder)
        system("mvn clean dependency:copy-dependencies package",show.output.on.console = TRUE)
        
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