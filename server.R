library(forecast)
library(ggplot2)
library(tidyquant)
library(scales)

# Define server function
server <- function(input, output) {
  source("functions.R", local = TRUE)
  
  # Get current date
  cur.date = Sys.Date()
  
  # Define event for input button: clicking will download the stock price data
  observeEvent(input$button, {
    symbol = input$symbol
    data = NULL
        # Use try statement in case symbol is invalid
        try({
        data = getSymbols(symbol, from = '2019-01-01',
                      to = input$date[2], warnings = FALSE,
                      auto.assign = FALSE)
    })
    
    # Check that data was downloaded
    if(!is.null(data)){
        y.name = paste(symbol, 'Close', sep = '.')
        data.df <- convert.to.dataframe(data)
        agg.data <- aggregate.data(data.df, y.name, agg.by = 'month')
        # Choose the number of months ahead to forecast, h.step as the end of the plot range
        h.step = max(elapsed_months(input$date[2], cur.date),1)
        fc <- forecast.data(agg.data, y.name, h.step = h.step, agg.by = 'month')

      #Create lineplot of time-series stock data and forecast (if selected)
      output$lineplot <- renderPlot({
      if(input$forecast){
        ylims = c(max(0, min(fc$lw2, agg.data$x)), max(agg.data$x, fc$up2))
        ggplot(data = fc) + 
          geom_ribbon(aes(x = Date, y = y, ymin = lw1, ymax = up1), fill = 'red', alpha = 0.2) +
          geom_ribbon(aes(x = Date, y = y, ymin = lw2, ymax = up2), fill = 'salmon', alpha = 0.2) +
          geom_line(aes(x = Date, y = y), linetype = 'dotted', color = 'red') + 
          geom_line(data = agg.data, aes(x = Date,  y=x)) + 
          theme(axis.text.x=element_text(angle = 0, hjust = 0, vjust = 0)) + 
          xlab('') + ylab('Price') + ggtitle(paste(symbol, 'Stock Forecast')) + 
          scale_x_date(labels = date_format("%b-%Y"), date_breaks ="3 months",
                       date_minor_breaks = "1 month",
                       limits = as.Date(c(input$date[1], input$date[2]))) + 
          coord_cartesian(ylim = ylims)
      }else{
          ylims = c(max(0, min(agg.data$x)), max(agg.data$x))
          ggplot(data = agg.data) + 
          geom_line(aes(x = Date,  y=x)) + 
          theme(axis.text.x=element_text(angle = 0, hjust = 0, vjust = 0)) + 
          xlab('') + ylab('Price') + ggtitle(paste(symbol, 'Stock Data')) + 
          scale_x_date(labels = date_format("%b-%Y"), date_breaks ="3 months",
                       date_minor_breaks = "1 month",
                       limits = as.Date(c(input$date[1], input$date[2]))) + 
            coord_cartesian(ylim=ylims)
      }
      
    })## End renderPlot

  } ## End if checking if data is NULL
  })## End observeInput

} # Close server function