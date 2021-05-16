library(shinythemes)

# Define UI
ui <- fluidPage(theme = shinytheme("lumen"),
                titlePanel("Stock Price Forecast"),
                sidebarLayout(
                  sidebarPanel(
                    
                    # Select stock symbol to get 
                    textInput(inputId = "symbol", label = "Symbol", value = "TSLA"),
                    
                    # Select date range to be plotted - default shows 9 months data, 3 months forecast
                    dateRangeInput("date", strong("Plot range"), 
                                   start = as.Date(cur.date) %m-% months(9), 
                                   end = as.Date(cur.date) %m+% months(3)), 
                    
                    # Select whether to overlay smooth trend line
                    checkboxInput(inputId = "forecast", label = strong("Overlay Forecast"), value = FALSE),
                    
                    actionButton(inputId = 'button', label = 'Update Plot'),
                  ), 
                  # Output: Description, lineplot, and reference
                  mainPanel(
                    plotOutput(outputId = "lineplot", height = "300px")
                  )
                )
)