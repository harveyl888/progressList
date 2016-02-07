library(shiny)
library(progressList)


server <- function(input, output, session) {
}

prog.labels <- c('read file', 'data reduction', 'normalization', 'trends', 'visualization')
prog.status <- c('waiting', 'waiting', 'inactive', 'waiting', 'waiting')

ui <- fluidPage(
  titlePanel(title = 'progressList example'),
  br(),
  progressList('progresslist1', prog.labels, prog.status)
)

shinyApp(ui=ui, server=server)
