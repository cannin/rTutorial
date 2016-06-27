shinyServer(function(input, output) {
  output$plot <- renderPlot({
    a <- runif(input$num)
    b <- runif(input$num)
    plot(a, b)
  })
})