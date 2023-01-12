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
library(plotly)
#load data
data <- read.csv("listings_detailed.csv")
neighbourhoods <- unique(data$neighbourhood)
# Remove the "$" and "," characters and convert to numeric
data$price <- as.numeric(gsub("[$,]", "", data$price))
ui <- fluidPage(
  # Add a select input for filtering
  selectInput("filter_column", "Filter by Neighbourhood:", 
              choices = neighbourhoods),
  # Add a plotly output to display the histogram
  plotlyOutput("histogram")
)

server <- function(input, output) {
  # Create a reactive function to filter the data based on the input
  filtered_data <- reactive({
    data %>%
      filter(neighbourhood == input$filter_column)
  })

  # Create a histogram of the "price" variable
  histogram <- ggplot(filtered_data(), aes(x = price)) +
    geom_histogram(bins = 50)

  # Convert the ggplot object to a plotly object
  plot <- ggplotly(histogram)

  # Render the plotly object in the Shiny app
  output$histogram <- renderPlotly({
    plot
  })
}

```