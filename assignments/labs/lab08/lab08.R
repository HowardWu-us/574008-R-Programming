# %%
# install.packages("shiny")
library(shiny)
# runExample("01_hello")


# UI
ui <- fluidPage(
    titlePanel("Hello NYCU!"),
    sliderInput("bins", "Please select bins", min = 1, max = 50, value = 30),
    plotOutput(outputId = "distPlot")
)

# %%
# Server
server <- function(input, output) {
    output$distPlot <- renderPlot({
        x <- faithful$eruptions
        bins <- seq(min(x), max(x), length.out = as.numeric(input$bins) + 1)

        hist(x,
            breaks = bins, col = "#75AADB", border = "white",
            xlab = "Eruption Duration (in mins)",
            main = "Histogram of Eruption Duration"
        )
    })
}
# %%
shinyApp(ui = ui, server = server)
# Create Shiny app