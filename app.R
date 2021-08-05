library(shiny)

# Source the function that creates the user-interface
source("ui.R")

# Source the function that creates the server instructions
source("server.R")

# Create Shiny object
shinyApp(ui = ui, server = server)