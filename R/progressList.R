.checkStates <- function(s) {
  progressListStates <- c('active', 'completed', 'waiting', 'inactive', 'failed')
  if(all(s %in% progressListStates)) {
    return(TRUE)
  } else {
    return(paste0('Unknown state(s) ', paste0(s[!s %in% progressListStates], collapse = ', ') ,'.  Allowable states: ', paste0(progressListStates, collapse = ', ')))
  }
}

#' Create a new progressList
#'
#' @param inputId The input id of the widget
#' @param label A list of labels - one for each step in the process
#' @param status A list of status flags - one for each step in the process
#'
#' @export
progressList <- function(inputId, label, status) {
  shiny::addResourcePath("prog", system.file('www', package='progressList'))
  statusOK <- .checkStates(status)
  if (!statusOK == TRUE) stop(statusOK)
#  if(!.checkStates(status) == TRUE) stop(.checkStates(status))
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

#' Update a progress flag to a new state
#'
#' @param session The session object passed to function given to \code{shinyServer}
#' @param value Text string of the status to update
#' @param newstatus Updated status
#'
#' @export
progUpdate <- function(session, value, newstatus) {
  statusOK <- .checkStates(newstatus)
  if (!statusOK == TRUE) stop(statusOK)
  session$sendCustomMessage('progUpdate', message = list(label=value, newstatus=newstatus))
}

#' Update multiple flags to new states
#'
#' @param session The session object passed to function given to \code{shinyServer}
#' @param label List of labels to update
#' @param status List of new states
#'
#' @export
progUpdateList <- function(session, label, status) {
  statusOK <- .checkStates(status)
  if (!statusOK == TRUE) stop(statusOK)
  for (i in 1:length(label)) {
    session$sendCustomMessage('progUpdate', message = list(label=label[[i]], newstatus=status[[i]]))
  }
}
