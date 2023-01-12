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
# Load the data frame and extract the unique values from the "neighbourhood" column
data <- read.csv("listings_detailed.csv")
neighbourhoods <- unique(data$neighbourhood)

# Define the UI
ui <- fluidPage(
  # Add a select input for filtering
  selectInput("filter_column", "Filter by Neighbourhood:", 
              choices = neighbourhoods),
  # Add a table to display the filtered data
  tableOutput("filtered_data")
)

# Define the server function
server <- function(input, output) {
  # Create a reactive function to filter the data based on the input
  filtered_data <- reactive({
    data %>%
      filter(neighbourhood == input$filter_column)
  })

  # Render the filtered data as a table
  output$filtered_data <- renderTable({
    filtered_data()
  })
}

# Run the app
shinyApp(ui = ui, server = server)




```