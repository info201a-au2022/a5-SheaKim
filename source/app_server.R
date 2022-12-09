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
df1 <- read.csv("https://raw.githubusercontent.com/info201a-au2022/a5-SheaKim/main/data/owid-co2-data.csv")

# function to find country w/ highest CO2 per GDP
country_highest_co2_gdp <- function() {

x <- df1 %>%
  filter(co2_per_gdp == max(co2_per_gdp, na.rm = TRUE)) %>%
  pull(country)

return(x)
}

# year of highest CO2 per GDP
year_highest_co2_gdp <- function() {

  x <- df1 %>%
  filter(co2_per_gdp == max(co2_per_gdp, na.rm = TRUE)) %>%
  pull(year)

  return(x)
}


# country w/ highest GDP function
country_highest_gdp <- function() {

  x <- df1 %>%
  filter(country != "World") %>%
  filter(gdp == max(gdp, na.rm = TRUE)) %>%
  pull(country)

  return(x)
}

# year w/ highest GDP function
year_highest_gdp <- function() {

  x <- df1 %>%
  filter(country != "World") %>%
  filter(gdp == min(gdp, na.rm = TRUE)) %>%
  pull(year)

  return(x)

}

# test code
y <- df1 %>%
  filter(country == "China" | country == "South Korea")

plot1 <- ggplot(y, aes(x = country, y = co2_per_gdp)) +
  geom_col(aes(x = year, y = co2_per_gdp, fill = country), position = "dodge") +
  labs(x = "Year", y = "CO2 Emissions per GDP (kg/$ of GDP)",
       title = "CO2 Emissions per GDP Over a Yearly Range",
       caption = "Figure 1. Figure description here")


# df for all country names (options)
unique <- df1 %>%
  filter(year == "2021")

# df for all available years (options)
dates <- df1 %>%
  filter(country == "Asia")



my_server <- function(input, output) {

  # outputs a slider
  output$range <- renderPrint({input$slider1})

  #filters df based on slider years and chosen countries
  choose_countries <- reactive({df1 %>%
      filter(country == input$count1 | country == input$count2) %>%
      filter(year >= input$slider1[1], year <= input$slider1[2])
  })

  #filters df based on slider years and chosen countries
  choose_countries1 <- reactive({df1 %>%
      filter(country == input$count3 | country == input$count4) %>%
      filter(year >= input$slider1[1], year <= input$slider1[2])

    })

# renders first plot
  output$graph <- renderPlotly({

    ggplot(choose_countries()) +
      geom_col(aes(x = year, y = co2_per_gdp, fill = country),
               position = "dodge") +
      labs(x = "Year", y = "CO2 Emissions per GDP (kg/$ of GDP)")

  })

# renders second plot
  output$graph1 <- renderPlotly({

    ggplot(choose_countries1()) +
      geom_col(aes(x = year, y = gdp, fill = country), position = "dodge") +
      labs(x = "Year", y = "Gross Domestic Product (GDP, in international $)")

  })

}
