#' tryCatchShiny
#'
#' Open modal box on error in Shiny application.
#' \strong{Requires \link[shinyalert]{useShinyalert}} - otherwise modal won't pop up.
#'
#' @param expr expression
#'
#' @inheritParams on_error
#' @inheritParams shinyalert::shinyalert
#' @inheritDotParams on_error
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   tryCatchShiny::run_example("01-shiny-app")
#' }
tryCatchShiny <- function(expr, stop_with_req = TRUE, title = "Error", size = "l", ...) {
  base::tryCatch(expr, error = function(e) {
    on_error(e, stop_with_req = stop_with_req,  title = title, size = size, ...)
  })
}


#' on_error
#'
#' Open modal window with error message.
#'
#' @param e object of \code{simpleError} class
#' @param stop_with_req logical (default \code{TRUE}). If \code{TRUE}, then
#' stop shiny code execution with \link[shiny]{req}
#' @param ... optional arguments for \link[shinyalert]{shinyalert}
#'
#' @inheritParams shinyalert::shinyalert
#'
#' @importFrom methods is
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   tryCatchShiny::run_example("01-shiny-app")
#' }
on_error <- function(e, stop_with_req = TRUE,  title = "Error",  size = "l", ...) {
  if (!is(e, "simpleError"))
    stop("Object `e` is not of `simpleError` class, but :", paste0(class(e), collapse = ", "))
  logger::log_error(e$message)
  shinyalert::shinyalert(title = title, type = "error", size = size, text = e$message, ...)
  if (isTRUE(stop_with_req))
    shiny::req(FALSE)
}


#' recover_on_error
#'
#' Function to be used in combination with \code{shiny.error} option:
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
#' }
#'
recover_on_error <- function() {
  envir <- parent.frame(1)
  on_error(envir$e)
}




