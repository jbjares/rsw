Util <- list(
  progressBarWithEndFlag = function(endFlag){
    #FIXME
    totalFlag <- 1000000
    total <- totalFlag
    # create progress bar
    pb <- txtProgressBar(min = 0, max = total, style = 3)
    for(i in 1:total){
      Sys.sleep(0.1)
      # update progress bar
      setTxtProgressBar(pb, i)
      
      if(endFlag==true){
        setTxtProgressBar(pb, totalFlag)
      }
    }
    close(pb)
  }
  
)