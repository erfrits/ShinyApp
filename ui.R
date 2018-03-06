#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Linear Regression Data Simulation Tool"),
  
  verticalLayout(
      
      h4("Description"),
      div("The tool creates downloadable simulated data for the linear model", 
          em("y = b0 * x0 + b1 * x1 + b2 * x2 + b3 * x3"),
          ", where ", em("b0"), "is the interception (for all ", em("x0 = 1"), ")."
        ),
      h5("Settings"),
      div(
        tags$ul("Value: the theoritcal coefficient of the variable"),
        tags$ul("Min: the lowest value of the variable"),
        tags$ul("Max: the hoghest value of the variable"),
        tags$ul("Random values: if checked the values of the variable selected 
                from uniform distribution randomly, else they will be in equal distance with ascending value"
                )
      ),
      tags$hr(),
  
      # Sidebar with the settings
      sidebarLayout(
        sidebarPanel(
            h4("Settings"),
            numericInput("obs", "Observations:", 10, min = 1, max = 1000, value = 10),
            strong(fixedRow(
                column(2, "Variable"),
                column(2, "Value"),
                column(2, "Min"),
                column(2, "Max"),
                column(2, "Random values")
            )),
            fixedRow(
                column(2, "Interception"),
                column(2, numericInput("int.mu", "", 3, value = 0)),
                column(2, ""),
                column(2, ""),
                column(2, "")
            ),
            fixedRow(
                column(2, "X1"),
                column(2, numericInput("x1.val", "", value = 1)),
                column(2, numericInput("X1.min","", value = 1)),
                column(2, numericInput("X1.max","", value = 10)),
                column(2, checkboxInput("x1.r", "", value = FALSE))
            ),
            fixedRow(
                column(2, "X2"),
                column(2, numericInput("x2.val", "", value = 1)),
                column(2, numericInput("X2.min","", value = 1)),
                column(2, numericInput("X2.max","", value = 10)),
                column(2, checkboxInput("x2.r", "", value = FALSE))
            ),
            fixedRow(
                column(2, "X3"),
                column(2, numericInput("x3.val", "", value = 1)),
                column(2, numericInput("X3.min","", value = 1)),
                column(2, numericInput("X3.max","", value = 10)),
                column(2, checkboxInput("x3.r", "", value = FALSE))
            ),
            fixedRow(
                column(8, numericInput("e.sig","Standard deviaton of error", value = 0.1))
            )#,
            #actionButton("btnGen","Generate")
        ),
        
        # Show the generated data and the download button
        mainPanel(
            verticalLayout(
                downloadButton('btnDL','Download'),     
                tableOutput('outTbl')
            )

        )
      )
  )
))
