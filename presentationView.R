source("global.R")
source("swDAO.R")
source("Util.R")
library(lattice)

Presentation <- list(

  showAllAccessFromTheLastTwoYears = function(fullDF,serviceName){
    ag_pp <- DAO$aggregateDateAndCountryOfAcessByServiceName(fullDF,serviceName)
    ag_pp_acess_sum <- DAO$summarizeAAccessPerCountry(ag_pp)
    ##return(ag_pp_acess_sum)
    require(ggplot2)
    require(reshape)

    # or plot on different plots
    m <- melt(ag_pp_acess_sum ,  id = 'countries', variable_name = 'total_share')
    p <- ggplot(m, aes(total_share,countries),group="total_share") + geom_line() + facet_grid(. ~ total_share)
    print(p)
  },
  
  showSummarizedMarketShareByServiceName = function(fullDF,serviceName){
    ag_pp <- DAO$aggregateDateAndCountryOfAcessByServiceName(fullDF,serviceName)
    ag_pp_access_sum <- DAO$summarizeAAccessPerCountry(ag_pp)
    summary(ag_pp_access_sum$total_share)
  },
  
  showSummarizedMarketShareByAllServices = function(fullDF){
    ag_pp <- DAO$aggregateDateAndCountryOfAcessByServiceName(fullDF,"ALL")
    ag_pp_access_sum <- DAO$summarizeAAccessPerCountry(ag_pp)
    summary(ag_pp_access_sum$total_share)
  },
  
  showRankingByCountry = function(fullDF,serviceName){
    ag_pp <- DAO$aggregateDateAndCountryOfAcessByServiceName(fullDF,serviceName)
    ag_pp_acess_sum <- DAO$summarizeAAccessPerCountry(ag_pp)
    ##return(ag_pp_acess_sum)
    require(ggplot2)
    require(reshape)
    
    # or plot on different plots
    m <- melt(ag_pp_acess_sum ,  id = 'countries', variable_name = 'total_share')
    p <- ggplot(m, aes(total_share,countries),group="total_share") + geom_line() + facet_grid(. ~ total_share)
    print(p)
  }
  
)