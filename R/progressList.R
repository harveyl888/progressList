#' Create a new progressList
#'
#' @param inputId The input id of the widget
#' @param label A list of labels - one for each step in the process
#' @param status A list of status flags - one for each step in the process
#'
#' @export
progressList <- function(inputId, label, status) {
  shiny::addResourcePath("prog", system.file('www', package='progressList'))
  iconTags <- list()
  for (i in 1:length(label)) {
    iconTags[[i]] <- shiny::tags$p(id = paste0(inputId, '_', i), proglistid=label[[i]], class=paste0("prog-list-", status[[i]]), label[[i]])
  }
  sx_progresslist <- shiny::div(id = inputId, class = "shiny-input-container", tagList(iconTags))
  htmltools::htmlDependencies(sx_progresslist) <- list(
    htmltools::htmlDependency("font-awesome", "4.5.0", c(href = "shared/font-awesome"), stylesheet = "css/font-awesome.min.css"),
    htmltools::htmlDependency("progressList", packageVersion("progressList"), src = c("href" = "prog"), script = "progressList.js", stylesheet = "progressList.css")
  )
  sx_progresslist
}
