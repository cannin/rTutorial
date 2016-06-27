shinyUI(fluidPage(
  titlePanel("Hello World!"),
  sidebarLayout(
    sidebarPanel(textInput("num", label="Number", value="10")),
    mainPanel(plotOutput("plot"))
  )
))