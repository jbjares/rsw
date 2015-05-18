
ExtractMass <- list(
  
  codeAndCountyExtract = function(){
    fileVar <- paste0(gsub("\\\\", "/", getwd()),"/iTunesCodesAndCountries.csv")
    if(!file.exists(fileVar)){
      source("codeAndCountyExtract.R")
    }else{
      reply <- readline("The file [iTunesCodesAndCountries.csv] already exists. Do you want to update? (Y/N)")
    }
    
    if(reply=="Y"){
      source("codeAndCountyExtract.R")
    }
  },
  
  basicDataExtract = function(){
    fileVar <- paste0(gsub("\\\\", "/", getwd()),"/basicData.csv")
    if(!file.exists(fileVar)){
      source("basicDataExtract.R")
    }else{
      reply <- readline("The file [basicData.csv] already exists. Do you want to update? (Y/N)")
    }
    
    if(reply=="Y"){
      source("basicDataExtract.R")
    }
    
  },
  
  geoLocDataExtract = function(){
    fileVar <- paste0(gsub("\\\\", "/", getwd()),"/geoLoc.csv")
    if(!file.exists(fileVar)){
      source("geoLocationExtract.R")
    }else{
      reply <- readline("This file [geoLoc.csv] already exists. Do you want to update? (Y/N)")
    }
    
    if(reply=="Y"){
      source("geoLocationExtract.R")
    }
    
  },
  
  playGen = function(){
    source("playGen.R")
  }
)

ExtractMass$codeAndCountyExtract()
ExtractMass$basicDataExtract()
ExtractMass$geoLocDataExtract()
ExtractMass$playGen()