library(shiny)
library(progressList)

prog.labels <- c('active', 'completed', 'waiting', 'inactive', 'failed')
prog.status <- c('active', 'completed', 'waiting', 'inactive', 'failed')

server <- function(input, output, session) {
  observeEvent(input$butChange, {
#    progUpdate(session, 'data reduction', 'inactive')
    progUpdateList(session, prog.labels[2:4], rep('active', 3))
  })
}

ui <- fluidPage(
  titlePanel(title = 'progressList example'),
  br(),
  progressList('progresslist1', prog.labels, prog.status)
#  actionButton('butChange', 'change status #2-4')
)

shinyApp(ui=ui, server=server)
