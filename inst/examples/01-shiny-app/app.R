library(shinydashboard)
library(tryCatchShiny)

# shinyCallingHandlers <- function (expr) {
#   withCallingHandlers(captureStackTraces(expr), error = function(e) {
#
#     browser()
#
#     if (inherits(e, "shiny.silent.error"))
#       return()
#     handle <- getOption("shiny.error")
#     if (is.function(handle))
#       handle()
#   })
# }

options(shiny.error = tryCatchShiny::recover_on_error)

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
           ),
           box(width = NULL,
               shiny::actionButton("btn3", "Throw Silent Error")
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

      stop("!!! Test Error #2 !!!")

  })

  observeEvent(input$btn3, {

    print("!!! Test Error #3: Silent error !!!")
    validate(need(NULL, FALSE))

  })

}

shinyApp(ui = ui, server = server)
