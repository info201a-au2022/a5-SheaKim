#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(tidyverse)
library(dplyr)

# Load data
df1 <- read.csv("../data/owid-co2-data.csv")


# Introduction. The introductory page (tab) should introduce the topic. 
# Specifically, your report should describe the variables you have chosen 
# to analyze and make clear measure(s) of CO2 emission you are focusing on.  
# Then, you should share at least three relevant values of interest. 
# These will likely be calculated using your DPLYR skills, answering questions 
# such as: 
#   
#   What is the average value of my variable across all the counties (in the current year)?
#   Where is my variable the highest / lowest?
#   How much has my variable change over the last N years?
#   You should calculate these values in your app_server.R file, and display them in your user interface using the appropriate method. 
# 
# [ ] Complete: The introductory material, focussed on the specifics of the application 
# [ ] Complete: Variables and measure of C02 are described
# [ ] Complete: At least three automatically generated values presented 
# [ ] Complete: All numbers formatted thoughtfully, with appropriate units
# [ ] Complete: Effective use of headings, fronts, and other reporting features. 


country_highest_co2_gdp <- function() {

x <- df1 %>%
  filter(co2_per_gdp == max(co2_per_gdp, na.rm = TRUE)) %>%
  pull(country)

return(x)
}


year_highest_co2_gdp <- function(){
  
  x <- df1 %>%
  filter(co2_per_gdp == max(co2_per_gdp, na.rm = TRUE)) %>%
  pull(year)

  return(x)
}


country_highest_gdp <- function(){
  
  x <- df1 %>%
  filter(country != "World") %>%
  filter(gdp == max(gdp, na.rm = TRUE)) %>%
  pull(country)

  return(x)
}

year_highest_gdp <- function(){
  
  x <- df1 %>%
  filter(country != "World") %>%
  filter(gdp == min(gdp, na.rm = TRUE)) %>%
  pull(year)
  
  return(x)

}

y <- df1 %>%
  filter(country == "China" | country == "South Korea")

plot1 <- ggplot(y, aes(x = country, y = co2_per_gdp)) +
  geom_col(aes(x = year, y = co2_per_gdp, fill = country), position = "dodge")+
  labs(x = "Year", y = "CO2 Emissions per GDP (kg/$ of GDP)", 
       title = "CO2 Emissions per GDP Over a Yearly Range", caption = "Figure 1. Figure description here")



unique <- df1 %>%
  filter(year == "2021")


dates <- df1 %>%
  filter(country == "Asia")

# Define server logic required to draw a histogram
my_server <- function(input, output) {

  # filters dataframe with user choice of 2 states 
  
  output$range <- renderPrint({ input$slider1 }) 
  
  choose_countries <- reactive({df1 %>%
      filter(country == input$count1 | country == input$count2) %>%
      filter(year >= input$slider1[1], year <= input$slider1[2])
  })
  

  choose_countries1 <- reactive({df1 %>%
      filter(country == input$count3 | country == input$count4) %>%
      filter(year >= input$slider1[1], year <= input$slider1[2])
    
    })
  
  output$graph <- renderPlotly({
    
    ggplot(choose_countries()) +
      geom_col(aes(x = year, y = co2_per_gdp, fill = country), position = "dodge") +
      labs(x = "Year", y = "CO2 Emissions per GDP (kg/$ of GDP)")
  
  })

  output$graph1 <- renderPlotly({
    
    ggplot(choose_countries1()) +
      geom_col(aes(x = year, y = gdp, fill = country), position = "dodge") +
      labs(x = "Year", y = "Gross Domestic Product (GDP, in international $)")
    
  })

}
