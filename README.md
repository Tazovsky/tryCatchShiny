# tryCatchShiny

Politely show error message in modal window instead of crashing Shiny app.

## Installation

```r
remotes::install_github("Tazovsky/tryCatchShiny")
```


## Usage

Set option:

```r
options(shiny.error = tryCatchShiny::recover_on_error)
```

and add `shinyalert::useShinyalert()` to UI part of your Shiny app.


## Examples

Run example Shiny app with `tryCatchShiny::run_example("01-shiny-app")`.

