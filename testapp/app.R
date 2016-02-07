library(shiny)
library(progressList)

prog.labels <- c('read file', 'data reduction', 'normalization', 'trends', 'visualization')
prog.status <- c('active', 'completed', 'waiting', 'inactive', 'failed')

server <- function(input, output, session) {
  observeEvent(input$butChange, {
    progUpdate(session, 'data reduction', 'inactive')
  })
}

ui <- fluidPage(
  titlePanel(title = 'progressList example'),
  br(),
  progressList('progresslist1', prog.labels, prog.status),
  actionButton('butChange', 'change status #2')
)

shinyApp(ui=ui, server=server)
