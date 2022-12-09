#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(dplyr)
library(shiny)
library(ggplot2)
library(tidyverse)
library(shinythemes)
library(plotly)


# source proper files
source("app_ui.R")
source("app_server.R")

# Run the application
shinyApp(ui = page_ui, server = my_server)
