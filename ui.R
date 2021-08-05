library(shinythemes)
library(lubridate)

# Define UI
ui <- fluidPage(theme = shinytheme("lumen"),
                titlePanel("Stock Price Forecast"),
                sidebarLayout(
                  sidebarPanel(
                    
                    # Select stock symbol to get 
                    textInput(inputId = "symbol", label = "Symbol", value = "VOO"),
                    
                    # Select date range to be plotted - default shows 9 months of data and 3 month forecast
                    dateRangeInput("date", strong("Plot range"), 
                                   start = Sys.Date() %m-% months(9), 
                                   end = Sys.Date() %m+% months(3)), 
                    
                    # Select whether to overlay forecast and confidence intervals
                    checkboxInput(inputId = "forecast", label = strong("Overlay Forecast"), value = FALSE),
                    
                    actionButton(inputId = 'button', label = 'Update Plot'),
                  ), 
                  # Output: Description, lineplot, and reference
                  mainPanel(
                    plotOutput(outputId = "lineplot", height = "300px")
                  )
                )
)