library(shiny)

## Get today's date
cur.date <- Sys.Date()

source("ui.R")
source("server.R")

# Create Shiny object
shinyApp(ui = ui, server = server)