#we loaded the packages which i need
library(shiny)
library(ggplot2)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(session,input, output) {
  
  
  #read the data input as .csv and save it in object called dataFile
  data <- reactive({
    inFile <-input$dataFile
    if(is.null(inFile))
      return(NULL)
    read.csv(inFile$datapath,stringsAsFactors = F)
  })
 
  #we add input to get columns names in selcet input X
  observeEvent(input$dataFile,{
    dd<-data()
    item <- names(dd)
    updateSelectInput(session,"columnX",choices = c("None",item))
  })

  #we add input to get columns names in selcet input Y
  observeEvent(input$dataFile,{
    dd<-data()
    item <- names(dd)
    updateSelectInput(session,"columnY",choices = c("None",item))
  })
  
  #we add input to select the flavour color
  observeEvent(input$dataFile,{
    dd<-data()
    item <- names(dd)
    updateSelectInput(session,"color",choices = c("None",item))
  })
  
  #we select facet grid columns for row
  observeEvent(input$dataFile,{
    dd<-data()
    item <- names(dd)
    updateSelectInput(session,"facetRow",choices = c(None=".",item))
  })
  
  #we select facet grid columns for col
  observeEvent(input$dataFile,{
    dd<-data()
    item <- names(dd)
    updateSelectInput(session,"facetCol",choices = c(None=".",item))
  })
  
   #this output for plot panel 
   output$plot <- renderPlot({
     dd <-data()
     xx<-input$columnX
     xx<-dd[,xx]
     yy<-input$columnY
     yy<-dd[,yy]
     
    # facetcol <- input$facetCol
     #facetcol<-as.factor(dd[,facetcol])
     
     #facetrow <- input$facetRow
     #facetrow<-as.factor(dd[,facetrow])
     
     coloor <- input$color
     coloor<-as.factor(dd[,coloor])
     g<- ggplot(dd,aes(xx,yy,color = coloor))
       g+geom_point()+geom_smooth(method = input$geomSmooth)+labs(x=input$columnX,y=input$columnY,title = input$graphText)+geom_hline(yintercept = input$hLine )+geom_vline(xintercept = input$vLine)
       #+facet_grid(facetrow~facetcol)

       
     })
   
   #this output for summary panel
   output$summary <- renderPrint({
     df <- data()
      
       str(df)
       br()
       summary(df)
       br()
       head(df)
   })
   
  # this output for table panel
   output$table <- renderTable({
     data()
   })
 
   
    })
