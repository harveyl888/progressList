library(shiny)
library(progressList)


server <- function(input, output, session) {
}

prog.labels <- c('read file', 'data reduction', 'normalization', 'trends', 'visualization')
prog.status <- c('active', 'completed', 'waiting', 'inactive', 'failed')

ui <- fluidPage(
  titlePanel(title = 'progressList example'),
  br(),
  progressList('progresslist1', prog.labels, prog.status)
)

shinyApp(ui=ui, server=server)
