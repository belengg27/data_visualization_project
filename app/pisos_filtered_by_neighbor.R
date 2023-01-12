---
title: "data_vis"
author: "group 20something"
date: "2022-12-29"
output: pdf_document
---
Load data 

# ```{r}
# calendar<- read.csv("calendar.csv")
# listings<- read.csv("listings.csv")
# listings_detailed<- read.csv("listings_detailed.csv")
# neighbourhoods<- read.csv("neighbourhoods.csv")
# reviews<- read.csv("reviews.csv")
# reviews_detailed<- read.csv("reviews_detailed.csv")
# ```
histogram of  data prices

```{r}
library(shiny)
library(maps)
library(mapproj)
library(dplyr)
library(ggplot2)
#load data
data <- read.csv("listings_detailed.csv")
neighbourhoods <- unique(data$neighbourhood_cleansed)

ui <- fluidPage(
  # Add a select input for filtering
  selectInput("filter_column", "Filter by Neighbourhood:", 
              choices = neighbourhoods),
  # Add a plot map
  leafletOutput("map")
)

server <- function(input, output) {
  # Create a reactive function to filter the data based on the input
  filtered_data <- reactive({
    data %>%
      filter(neighbourhood_cleansed == input$filter_column)
  })

  # Create a reactive function to generate the map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(data = filtered_data(), lat = filtered_data()$latitude, lng = filtered_data()$longitude)
  })

  # Render the histogram in the Shiny app
  output$histogram <- renderPlot({
    histogram()
  })
}



# Run the app
shinyApp(ui = ui, server = server)

```