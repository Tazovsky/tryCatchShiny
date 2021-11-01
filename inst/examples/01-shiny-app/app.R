library(shinydashboard)
library(tryCatchShiny)

options(shiny.error = recover_on_error)

header <- dashboardHeader(
  title = "tryCatchShiny app"
)

body <- dashboardBody(
  fluidRow(
    shinyalert::useShinyalert(),
    column(width = 9,
           box(width = NULL, solidHeader = TRUE,
               shiny::actionButton("btn1", "Throw Error")
           ),
           box(width = NULL,
               shiny::actionButton("btn2", "Throw Error")
           )
    )
  )
)

ui <- dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
)




server <- function(input, output, session) {

  observeEvent(input$btn1, {

    tryCatchShiny({

      stop("!!! Test Error #1 !!!")

    })

  })

  observeEvent(input$btn2, {

      stop("!!! Test Error #w !!!")

  })

}

shinyApp(ui = ui, server = server)
