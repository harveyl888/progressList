
# Example of using progressList for a number of subprocesses.

library(shiny)
library(progressList)

prog.labels <- c('read data', 'data reduction', 'skip this calculation', 'short calculation 1', 'long calculation 1', 'short calculation 2', 'long calculation 2')
prog.status <- rep('waiting', length(prog.labels))
prog.status[3] <- 'inactive'

server <- function(input, output, session) {

  process_01 <- function() {
    # simulate reading data
    Sys.sleep(2)
    return(TRUE)
  }

  process_02 <- function() {
    # simulate data reduction
    Sys.sleep(2)
    return(TRUE)
  }

  process_03 <- function() {
    # simulate calculation not run
    # this function will not be called
    return(TRUE)
  }

  process_04 <- function() {
    # simulate short calculation 1
    Sys.sleep(1)
    return(TRUE)
  }

  process_05 <- function() {
    # simulate long calculation 1
    Sys.sleep(5)
    return(TRUE)
  }

  process_06 <- function() {
    # simulate short calculation 2
    # this is designed to fail
    Sys.sleep(0.2)
    return(FALSE)
  }

  process_07 <- function() {
    # simulate long calculation 2
    # as this runs after the failed subprocess it will never be called
    Sys.sleep(5)
    return(TRUE)
  }

  runProcess <- function(n) {
    # run a specific process
    if (n == 1) {
      out <- process_01()
    } else if (n == 2) {
      out <- process_02()
    } else if (n == 3) {
      out <- process_03()
    } else if (n == 4) {
      out <- process_04()
    } else if (n == 5) {
      out <- process_05()
    } else if (n == 6) {
      out <- process_06()
    } else if (n == 7) {
      out <- process_07()
    } else {
      return (FALSE)
    }
    return(out)
  }

  observeEvent(input$butStart, {
    current.status <- prog.status
    for (i in 1:length(prog.labels)) {
      if (current.status[i] == 'waiting') {  # check to see if this subprocess should be run
        progUpdate(session, prog.labels[i], 'active')  # set state to active
        out <- runProcess(i)
        if (out == TRUE) {  # process = succesful - update state and move to next subprocess
          progUpdate(session, prog.labels[i], 'completed')  # set state to completed
        }
        if (out == FALSE) {  # failed process - set all subsequent processes as fail
          progUpdateList(session, prog.labels[i:length(prog.labels)], rep('failed', length(prog.labels) - i + 1))
          current.status[i:length(prog.labels)] <- 'failed'
        }
      }
    }
  })

  observeEvent(input$butReset, {
    progUpdateList(session, prog.labels, prog.status)
  })

  output$txtExplanation <- renderPrint({
    cat('Example of progressList.\nIn this example seven subprocesses are defined.\nSubprocess 3 is inactive and therefore skipped.\nSubprocess 6 is designed to fail and therefore subprocess 7 is never started.')
  })
}

ui <- fluidPage(titlePanel(title = 'progressList example'),
  br(),
  fluidRow(
    column(4,
           progressList('pl1', prog.labels, prog.status),
           br(),
           actionButton('butStart', 'start', class = 'btn-success'),
           actionButton('butReset', 'reset', class = 'btn-success')
    ),
    column(8, verbatimTextOutput('txtExplanation'))
  )
)

shinyApp(ui=ui, server=server)
