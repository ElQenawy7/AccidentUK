#we load libraries which need
library(shiny)
library(shinydashboard)
library(shinythemes)

# Define UI for application
#we will use dash board
#dash board devided into three parts:header, sidebar and body
#we write header for my dash board application
header <- dashboardHeader(
  title = "Analysis for Traffic Flow and Accidents" ,
  titleWidth = 400

)

sidebar <- dashboardSidebar(
  width = 400,
 
    
  fileInput(inputId ="dataFile",label = "choose data file",buttonLabel = "browse",placeholder = ".csv file",width = 400,accept=c('text/csv', 'text/comma-separated-values,text/plain')),
  #dateRangeInput(inputId = "dataDate",label = "insert peroid which need",start ="2000-01-01",end = "2016-12-31",min = "2000-01-01",max = "2016-12-31",format = "dd-mm-yyyy",weekstart = 1,width = 400),
  selectInput(inputId = "columnX",label = "select X columns",width = 400,choices =c("None") ,multiple = F),
  #uiOutput(outputId = "X"),
  selectInput(inputId = "columnY",label = "select Y columns",width = 400,choices =c("None")  ,multiple = F),
  #uiOutput(outputId = "Y"),
  selectInput(inputId = "color", label = "select color",choices = c(None ="", "green","red","yellow","blue"),width = 400 ,multiple = F),
  #uiOutput(outputId = "color"),
  selectInput(inputId = "facetRow",label = "Facet Row",choices = c(None="."),width = 400,multiple = F),
  #uiOutput(outputId = "facetRow"),
  selectInput(inputId = "facetCol",label = "Facet Column",choices = c(None="."),multiple = F,width = 400),
  #uiOutput(outputId = "facetCol"),
  textInput(inputId = "graphText",label = "write what graph mean",width = 400),
  #uiOutput(outputId = "graphText"),
  numericInput(inputId = "vLine", label = "vertical line",width = 400,value = 0),
  #uiOutput(outputId = "vLine"),
  numericInput(inputId = "hLine", label = "horizontal line",width = 400,value = 0),
  #uiOutput(outputId = "hLine"),
  radioButtons(inputId ="geomSmooth",label = "choose the smooth type if found",choices = c("None","lm","loess","rlm","gam","glm"),width = 400,inline = T)
  #uiOutput(outputId ="geomSmooth"),
  #actionButton(inputId = "RunButton", label = "Run",width = 370)
    
    )

body <- dashboardBody(
fluidRow(
    tabBox(width = 800,selected = "Plot",height = 900,side = "left",
    tabPanel(title ="Plot", plotOutput("plot")),
    tabPanel(title ="about Data", verbatimTextOutput("summary")),
    tabPanel(title ="Table", tableOutput("table"))
    )
  )
)

shinyUI(
dashboardPage(header, sidebar, body,skin = "purple")
)