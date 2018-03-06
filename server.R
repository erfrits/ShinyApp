#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    app_seed <- 8888
    
    df <- reactive({
        # generate the data either from uniform distribution or by sequence
        set.seed(app_seed)
        x0 <- rep(1, input$obs)
        df_out <- data.frame(x0)
        if(input$x1.r)
            x1 <- runif(input$obs, input$X1.min, input$X1.max)
        else
            x1 <- seq(input$X1.min, input$X1.max, (input$X1.max - input$X1.min)/(input$obs - 1))
        df_out <- cbind(df_out,x1)
        if(input$x2.r)
            x2 <- runif(input$obs, input$X2.min, input$X2.max)
        else
            x2 <- seq(input$X2.min, input$X2.max, (input$X2.max - input$X2.min)/(input$obs - 1))
        df_out <- cbind(df_out,x2)
        if(input$x3.r)
            x3 <- runif(input$obs, input$X3.min, input$X3.max)
        else
            x3 <- seq(input$X3.min, input$X3.max, (input$X3.max - input$X3.min)/(input$obs - 1))
        df_out <- cbind(df_out,x3)
        
        y <- input$int.mu + 
            input$x1.val * x1 +
            input$x2.val * x2 +
            input$x3.val * x3 +
            rnorm(input$obs ,0, input$e.sig)
        df_out <- cbind(y,df_out)
        
        # return result
        df_out
    })
    
    # create data and render it to a table
    output$outTbl <-  renderTable({
            
            d0 <- df()
            app_seed <- runif(1, 893, 99374829465)
            d0
           
    })
    
    # allow the user to download the file
    output$btnDL <- downloadHandler(
      filename = function() {
        paste('data-', Sys.Date(), '.csv', sep='')
      },
      content = function(file) {
        write.csv(df(), file, row.names = FALSE)
      }
    )
    
 
  
})
