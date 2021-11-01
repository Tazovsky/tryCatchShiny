#' run_example
#'
#' Runs example shiny app.
#'
#' @param example_dir example name
#'
#' @export
#'
run_example <- function(example_dir) {
  stopifnot(nzchar(example_dir))

  available_examples <-  list.files(system.file("examples", package = "tryCatchShiny"))

  if (!example_dir %in% available_examples)
    stop("Available examples are: ", paste0(available_examples, collapse = ", "))

  app_dir <- system.file("examples", example_dir,  package = "tryCatchShiny")

  shiny::runApp(app_dir, display.mode = "normal")
}
