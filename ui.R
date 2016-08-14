library(shiny)

# Define UI for application that draws a polar graph
ui <- shinyUI(fluidPage(

  # Sidebar with controls
  sidebarLayout(
    sidebarPanel( width=2,
                  sliderInput("a", label = "Angle Coefficient Numerator", min=1, max=360, value=3, step=1),
                  sliderInput("b", label = "Angle Coefficient Denominator", min=1, max=360, value=4, step=1),
                  sliderInput("step", label = "Step Size (degrees)", min=1, max=360, value=30, step=1),
                  selectInput("gtype", label = "Graph Type", selected = "lines",
                              choices=c("points",
                                        "lines",
                                        "points & lines",
                                        "histogram-like",
                                        "stair steps")),
                  selectInput("lty", label = "Line Type", selected = "solid",
                              choices = c("solid", "dashed", "dotted", "dotdash")),
                  sliderInput("lwd", label = "Line Width", min=1, max=40, value=20, step=1),
                  selectInput("color", label = "Graph Color", selected = "yellow",
                              choices = c("chartreuse", "yellow", "darkmagenta", "papayawhip",
                                          "darkred", "blue", "black")),
                  selectInput("bgcol", label = "Background Color", selected = "navy",
                              choices = c("turquoise", "coral", "magenta", "papayawhip",
                                          "red", "navy", "darkgray")),
                  sliderInput("zoom", label = "Zoom Factor", min=1, max=200, value=1, step = 1)
    ),
    
    # Show a plot of the polar graph
    mainPanel( width=10,
      tabsetPanel(
        tabPanel("Polar Sine Graph", plotOutput("polarPlot", height="840px")),
        tabPanel("Documentation", includeHTML("README.html"))
      )
    )
  )
)
)
