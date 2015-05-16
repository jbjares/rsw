

if(!("git2r" %in% rownames(installed.packages()))){
        install.packages("git2r")  
}

library(git2r)


pullRemoteJProject <- function(){
        ## Create a temporary directory to hold the repository
        path <- file.path(tempfile(pattern="git2r-"), "git2r")
        dir.create(path, recursive=TRUE)
        
        ## Clone the git2r repository
        repo <- clone("https://github.com/ropensci/git2r", path)
}

pullRemoteJProject()