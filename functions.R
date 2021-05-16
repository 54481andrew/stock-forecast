## Get number of elapsed months between two dates
elapsed_months <- function(end_date, start_date) {
  ed <- as.POSIXlt(end_date)
  sd <- as.POSIXlt(start_date)
  12 * (ed$year - sd$year) + (ed$mon - sd$mon)
}

## Function to convert xts object into dataframe with date info
convert.to.dataframe <- function(data){
  ## Get date information
  ind.dates <- index(data)
  ## Transform time series object into data frame
  data.df <- as.data.frame(data)
  data.df$date <- as.Date(ind.dates)
  data.df$week <- week(data.df$date)
  data.df$month <- month(data.df$date)
  data.df$year <- year(data.df$date)
  return(data.df)
}


## Function to aggregate data 
aggregate.data <- function(data.df, y.name, agg.by = 'month'){
  ## Aggregate dataset
  if(agg.by=='month'){
    agg.data <- aggregate(data.df[,y.name], by = data.df[,c('month', 'year')],
                          FUN = mean)
    agg.data[,'Date'] <- as.Date(with(agg.data,
                                      paste(year, month, '15', sep = '-')))
  }
  ## Rename default aggregation column
  agg.data[,y.name] = agg.data$x
  return(agg.data)
}


## Function to build a dataframe describing the forecast  
forecast.data <- function(agg.data, y.name, h.step = 3, agg.by = 'month'){  
  ## Transform aggregated data into a time-series object
  ts.obj <- xts(x = agg.data[,y.name], order.by = agg.data[,'Date'])
  ## Fit an Exponential Triple Smoothing forecast
  fit <- ets(ts.obj, model="ZZZ", damped=NULL, alpha=NULL, beta=NULL,
             gamma=NULL, phi=NULL, lambda=NULL, biasadj=FALSE,
             additive.only=FALSE, restrict=TRUE,
             allow.multiplicative.trend=FALSE)
  ## Get last date of aggregated data
  last.date <- max(agg.data$Date)
  ## Build forecast, convert to dataframe
  fc = as.data.frame(forecast(fit, h = h.step))
  ## Add a few simplified columns to the dataframe
  if(agg.by=='month'){
    fc$Date = seq(last.date %m+% months(1), last.date %m+% months(h.step), by = 'month') 
  }
  fc$y = fc[,'Point Forecast']
  fc$lw1 = fc[,'Lo 80']
  fc$up1 = fc[,'Hi 80']
  fc$lw2 = fc[,'Lo 95']
  fc$up2 = fc[,'Hi 95']
  return(fc)
}

