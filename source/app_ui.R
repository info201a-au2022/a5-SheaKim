#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

source("app_server.R")

country_highest_co2_gdp <- country_highest_co2_gdp()
year_highest_co2_gdp <- year_highest_co2_gdp()
country_highest_gdp <- country_highest_gdp()
year_highest_gdp <- year_highest_gdp()


# Define UI for application that draws a histogram
page_ui <- fluidPage(
  
  intro_page <- tabPanel(
    "Introduction", 
    titlePanel("Introduction"),
    
      # introduction text
      p("Climate change is and has always been an important issue in our world.
      Referring to long-term shifts in temperature and weather patterns, the Earth's
      average temperature and climate has always fluctuated. However, since the 1800s
      and the onset of human industrialization, climate change has been occurring at 
      a much faster rate than is sustainable."), 
      p("One of the reasons for this is CO2
      emissions. Some activities that release these emissions include burning of 
      fossil fuels, coal, and oil. In this exploration of global CO2 emissions, 
      we will look at CO2 by GDP (Gross Domestic Product), which is defined as 
      'Annual total production-based emissions of carbon dioxide (CO2), 
      excluding land-use change, measured in kilograms per dollar of GDP 
      (2011 international-$). Production-based emissions are based on 
      territorial emissions, which do not account for emissions embedded in 
      traded goods.' This value is the ratio between total CO2 emissions per unit 
      of GDP. The country with the highest CO2 by GDP was", paste0(country_highest_co2_gdp),
      "in", paste0(year_highest_co2_gdp),". In contrast, the country with the highest 
      GDP (on its own) was", paste0(country_highest_gdp, " in ", year_highest_gdp),"."),
    ),
  
  chart_2 <- tabPanel(
    "Interactive Charts",
    titlePanel("Interactive Charts"),
    
    sidebarLayout(
      sidebarPanel(
        
        # 2 dropdown menus to select 2 states
        selectInput(inputId = "count1", label = "Country 1",
                    choices = unique$country, multiple = FALSE
        ),
        selectInput(inputId = "count2", label = "Country 2",
                    choices = unique$country, multiple = FALSE
        ),
        
        selectInput(inputId = "count3", label = "Country 1",
                    choices = unique$country, multiple = FALSE
        ),
        selectInput(inputId = "count4", label = "Country 2",
                    choices = unique$country, multiple = FALSE
        ),
        
        sliderInput("slider1", label = h3("Year Range"), min = 1750, 
                    max = 2021, value = c(1750, 2021)),
        
      ),
      
      
      mainPanel(
        
        h3("CO2 Emissions per GDP of Two Countries Over a Yearly Range"),
        plotlyOutput("graph"),
        p("Figure 1. This figure charts the change in CO2 emissions per
          international $ of GDP as a time series. Using the drop down menu and 
          the slider, you can choose two countries to compare emissions per GDP 
          with, and also change the range of years to view. "),
        p(""),
        h3("Gross Domestic Product of Two Countries Over A Yearly Range"),
        plotlyOutput("graph1"),
        p("Figure 2. This figure charts the change in GDP as a time series. 
        Using the drop down menu and the slider, you can choose two countries 
        to compare GDP with, and also change the range of years to view. "),
        p(""),
        strong("Takeaways:"),
        p("- A country's emission by GDP does not always align with their actual GDP.
          They can be extremely different or similar depending on any given year. 
          For example Russia's emissions have gone down, but their GDP remains 
          on the rise."),
        p("- Different countries have different ranges of data. Some nations have 
          a very extensive historical record of GDP going back centuries, while 
          some have very sparse data."),
        p("- Policy could potentially be a big indicator of CO2 emissions- 
          countries that are known to have more stringent environmental 
          policies also generally have lower emissions."),
        p(""),
        p(""),
        p("Link to GitHub repository : ")
        
        
        )
    )
  )
  
  
  )




page_ui <- navbarPage(
  theme = shinytheme("cosmo"),
  "Analysis of CO2 Emissions by GDP Unit by Countries",
  intro_page,
  chart_2
)