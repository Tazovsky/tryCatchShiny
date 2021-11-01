#' tryCatchShiny
#'
#' @param expr
#' @param title
#' @param size
#' @param ...
#'
#' @export
#'
tryCatchShiny <- function(expr, stop_with_req = TRUE, title = "Error", size = "l", ...) {
  tryCatch(expr, error = function(e) {
    on_error(e, stop_with_req = stop_with_req,  title = title, size = size, ...)
  })
}


#' on_error
#'
#' @param e
#' @param stop_with_req
#' @param title
#' @param size
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
on_error <- function(e, stop_with_req = TRUE,  title = "Error",  size = "l", ...) {
  logger::log_error(e$message)
  shinyalert::shinyalert(title = title, type = "error", size = size, text = e$message, ...)
  if (isTRUE(stop_with_req))
    req(FALSE)
}


#' recover_on_error
#'
#' Function to be used with combination of \code{shiny.error} option:
#' \code{options(shiny.error = tryCatchShiny::recover_on_error)}
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   options(shiny.error = tryCatchShiny::recover_on_error)
#'
#'   or run example app:
#    tryCatchShiny::run_example("01-shiny-app")
#'
#' }
#'
recover_on_error <- function() {
  envir <- parent.frame(1)
  on_error(envir$e)
}




