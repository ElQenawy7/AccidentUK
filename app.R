library(shinydashboard)
library(shiny)
library(shinyjs)

library(ggplot2)
library(plotly)
library(stringr)
#library(devtools)
library(readr)
library(readxl)
library(RColorBrewer)
library(xlsx)
library(dplyr)
packageVersion('plotly')




# login Module: ---start-------------



Logged = FALSE

my_username <- data.frame(c('kareem','muhamed','ahmed','admin','visitor')) #query
my_password <- data.frame(c('211095','admin','admin','dmin','5780')) #query


# End login Module: ---start-------------




jscode <- "shinyjs.closeWindow = function() { window.close(); }"

options(shiny.maxRequestSize=1000*1024^2)



# header of dashboard page:
header <- dashboardHeader(title="Data science ",
                          
                          
                          
                          dropdownMenu(type = "messages",
                                       messageItem(
                                        from = "Analysis dept",
                                        message = "Sales are steady this month.",
                                        icon=
                                       ),
                                       messageItem(
                                        from = "data analyst",
                                        message = "How do I visualization?",
                                        icon = icon("question"),
                                        time = "13:45"
                                       ),
                                       messageItem(
                                        from = "Support",
                                        message = "The new server is ready.",
                                        icon = icon("life-ring"),
                                        time = "2014-12-01"
                                      )
                                       ),
                          dropdownMenu(type = "tasks", badgeStatus = "success",
                                       taskItem(value = 95, color = "green",
                                                "Data cleaning"
                                       ),
                                       taskItem(value = 90, color = "aqua",
                                                "Data visualization"
                                       ),
                                       taskItem(value = 40, color = "yellow",
                                                "shiny App"
                                       ),
                                       taskItem(value = 30, color = "red",
                                                "Documenation"
                                       ))# end task menu
                                       
                                       
                                       
                          ,

                          
  # Twitter Sharing Link
 tags$li(class = "dropdown",tags$a(href = "http://twitter.com/share?url=https://datascience-trafficflow-accidents.shinyapps.io/tool/&text=Traffic Flow And accidents Analyitics IN UK  ", target = "_blank", tags$img(height = "18px", src = "twitter.png") ) ),
                                 
                         
                          
 # Facebook Sharing link
  tags$li(class = "dropdown", tags$a(href = "https://datascience-trafficflow-accidents.shinyapps.io/tool/", target = "_blank", tags$img(height = "18px",  src = "facebook.png"))),
                                  
                         
                          
# LinkedIn Sharing link
 tags$li(class = "dropdown", tags$a(href = "https://datascience-trafficflow-accidents.shinyapps.io/tool/", target = "_blank",  tags$img(height = "18px", src = "linkedin.png")))
                                  
                         

                          
                          
                          )


# siderbar:

sidebar <-  dashboardSidebar(
 
 # Notificate button:
 
 tags$head(
  tags$style(
   HTML(".shiny-notification {
        position:fixed;
        top: calc(17%);;
        left: calc(50%);;
       
       text-align:center;;
           postion:relative;;
       left:255px;;
       opacity:1;;

        }
        "
   )
   )
   ),
 
 
 
 
# siderbarMenu:
 sidebarMenu(id="menu",
  # to close window 
  useShinyjs(),
  extendShinyjs(text = jscode, functions = c("closeWindow")),
  actionButton("close", "Exit"),
  actionButton("show", "instructions"),
  #-----------------------------------
  
  menuItem("Home", tabName = "home", icon = icon("home")),
  menuItem("introduction", tabName = "intro", icon = icon("list-ul")),
  
  menuItem("Datasets", tabName = "Datasets", icon = icon("table")),

  menuItem("Analysis tools", tabName = "gui" ,icon = icon("bar-chart-o"),  badgeLabel = "Moore..", badgeColor = "blue"),
  
menuItem("Prediction model", tabName = "model" ,icon = icon("binoculars"),badgeLabel = "Moore..", badgeColor = "blue"),
           
  #Reports menu item:--------------------
  menuItem("Reports", tabName = "report", icon = icon("file-text-o"), startExpanded = FALSE,
          menuSubItem(" Data cleaning",tabName='clean-report',icon = icon( "file-pdf-o")),
           menuSubItem(" Data visualization",tabName='visual-report',icon = icon( "file-pdf-o")),
           menuSubItem("Statistical Analysis",tabName='analysis-report',icon = icon( "file-pdf-o"))
          
           ),

# Project goals:
menuItem("Project Goals", tabName = "goals", icon = icon("tasks"), startExpanded = FALSE,
         menuSubItem(" First Problem",tabName='Q1',icon = icon( " fa-check")),
         menuSubItem(" Second Problem",tabName='Q2',icon = icon( " fa-check")),
         menuSubItem("Third Problem:",tabName='Q3',icon = icon( " fa-check")),
         menuSubItem("Fourth Problem:",tabName='Q4',icon = icon(" fa-check")),
         menuSubItem("Fifth Problem:",tabName='Q5',icon = icon(" fa-check"))
         
         ),
         
         

  #END project goals::----------------------------------------------
  
  
  menuItem("About", tabName = "about" ,icon = icon("info")),
  
  
  #----TEAM MEMBERS----
  hr(),
    tags$ul(tags$li("Team Members")),
br(),
  sidebarUserPanel(name = a("Kareem Rabea", target = "_blank_",
                            href = "https://www.linkedin.com/in/kareem-abd-el-razik-5b670214b/"), 
                   subtitle = " Data Analyst",
                   image = "kareem.jpg"),
  
  sidebarUserPanel(name = a("M.Gamal", target = "_blank_",
                            href = "https://www.linkedin.com/in/lqnawy/"), 
                   subtitle = "Applied Statistician",
                   image = "gemy.jpg"),
  
  sidebarUserPanel(name = a("M.EL Araby", target = "_blank_",
                            href = "https://www.linkedin.com/in/muhammad-ahmed-ibrahim/"), 
                   subtitle = " shiny developer",
                   image = "Elaraby.jpg"),
  
  
  sidebarUserPanel(name = a("A.AL Awady", target = "_blank_",
                            href = "https://www.facebook.com/ahmadooh.general"), 
                   subtitle = "Data visualization",
                   image = "ahmed.jpg"),
  
  sidebarUserPanel(name = a("M.Mokhtar", target = "_blank_",
                            href = "https://www.facebook.com/profile.php?id=100008418945235"), 
                   subtitle = "Data cleaning",
                   image = "mokthar.jpg"),
  hr()
  
  
 
  
  
 )
 
 )


# dashbord body:


body<-dashboardBody(id="body", 
                   
                   
                    
                    
 tabItems(
  
  # First tab content:home page:
  
  

tabItem( tabName="home",box(width=13,
   title =strong ("Analysis tool Using Shiny web Application"), status = "primary", solidHeader = TRUE,
  collapsible = TRUE, h1(class="h", imageOutput("image"),  p(class="p1","Data Analysis"),div(class="div1","Traffic flow and Accidents Analytics")))
         
         
         ),



tabItem( tabName="intro",box(width=16, title =strong (" Introduction "), status = "primary", solidHeader = TRUE, includeHTML('www/intro.html'))),



  
  #end home tabe:
  
  #Start Reports---------->>>>>>>>


# visualization report:
  tabItem(tabName="clean-report",
          
    box(width=13,
    title = span(id="sp"," Data prepration"), status = "primary", solidHeader = TRUE, collapsible = TRUE,
    downloadButton("report.pdf", "Download"),tags$iframe(style = "height:1000px; width:100%", src = "clean.html"))), 

  
                 # visualization report:    
  tabItem(tabName="visual-report",
          
          
     box(width=13,
     title = span(id="sp","Data visualiztion"), status = "primary", solidHeader = TRUE, collapsible = TRUE,
     
     uiOutput('view_visual')
     
      
    )),
      
        
# Regression Analysis report:

  tabItem(tabName="analysis-report",
          
        box(width=13,
      title = span(id="sp"," Statistical anlaysis"), status = "primary", solidHeader = TRUE,collapsible = TRUE,
    
        uiOutput("view_regression")
        
        
        )),


# project Goals:---------------------------



#firt goals
  tabItem(tabName="Q1",
          
    box(width=13,
  title = span(id="sp","How has changing traffic flow impacted accidents?"), status = "primary", solidHeader = TRUE,collapsible = TRUE,
  
  
  
  #gragh 1:
  div(id='befor_gragh','1.1-Annual Trafic volume by yeras in Britain'),
  plotOutput("first_1.1"),
  
  div(id='after_gragh','The gragh show that the traffic flow increasing with the Years and show that 2016 
      the large year fo traffic rate approximately 9.1% from the whole traffic low in UK. '),
  
  
  
  #gragh 2:
  div(id='befor_gragh','1.2-The Relation between Year and accidents Rate'),
  plotOutput("first_1.2"),
  
  div(id='after_gragh','The gragh show that taccidents Rate Decrease  with   the Years and show that 2014 
      has  accidents  rate  is smaller than   the whole accidents rate throgh Years in UK. '),
  
  
  
  
  
  
  
  #gragh 2:
  div(id='befor_gragh','1.3-The Relation between Year and accidents Rate'),
  plotOutput("first_1.3"),
  
  div(id='after_gragh','The gragh show that accidents Rate Decrease  with   the Years and show that 2014 
      has  accidents  rate  is smaller than   the whole accidents rate throgh Years in UK. ')
  
  
  
  
  
  )),

#End First Goal:


# second Goals
  tabItem(tabName="Q2",
          
  box(width=13,
 title = span(id="sp","Whate is Differnce between Rural And Urban area in accidents?"), status = "primary", solidHeader = TRUE, collapsible = TRUE,
 
 # first Gragh:
 
 div(id='befor_gragh','2.1-The Relation between  Rural and urban area and total number of accidents.'),
 plotOutput('second_2.1'),
 
 div(id='after_gragh','The gragh show that accidents Rate in the Urban area much more the accidents Rate in Rural areas  '),
 
 # second GRagh:
 
 
 
 
 div(id='befor_gragh','2.2- Differnce between Rural and urban in accidents by year.'),
 plotOutput('second_2.2'),
 
 div(id='after_gragh','The gragh show that accidents Rate incrase  in the Urban area  more than the in Rural areas  ')
 
 
 )),
#End second Goal:


#Third goal---------------------------------

  tabItem(tabName="Q3",
          
         box(width=13,
       title = span(id="sp","How has London has changed for cyclists?"), status = "primary", solidHeader = TRUE,collapsible = TRUE,
       
       
       # first GRagh:
       
       div(id='befor_gragh','3.1- Plot :the relation between Year and traffic volume for cart types.'),
       plotOutput('third_3.1'),
       
       div(id='after_gragh','The gragh show that  Traffic Flow for Cars Type Throgh Years  '),

       
       
       # second GRagh:
       
       div(id='befor_gragh','3.2-  Compute traffic volume For cars without pedal cycles on each Road Category.'),
       plotOutput('third_3.2'),
       
       div(id='after_gragh','The gragh show that  Trunk Motorway Roads are congested With Pedal cyclists  ')
       
       
       
       
       
       
       )),


# End third Goal:---------------------------



# Start Fourth Goal:--------


#Fourth Goal
  tabItem(tabName="Q4",
          
        box(width=13,
        title = span(id="sp","Which areas changed and  never change? and why? "), status = "primary", solidHeader = TRUE,collapsible = TRUE,
       
        # First Gragh:
       
        
        div(id='befor_gragh','4.1-  the traffic volume  rate in each area and determine The most crowded areas statistically.'),
        plotOutput('fourth_4.1'),
        
        div(id='after_gragh','East of England The larger area in Traffic Flow approximatly 15% from the Total traffic   ')
        
        
        
        )),



# fifth Goal
tabItem(tabName="Q5",
        
  box(width=13,
  title = span(id="sp","How have Rural and Urban areas differed in traffic ? "), status = "primary", solidHeader = TRUE,collapsible = TRUE,
  
  
  # First Gragh:
  
  
  div(id='befor_gragh','5.1-Plot:The relation of Road traffic volume according to The Rural and Urban areas.'),
  plotOutput('fifth_5.1'),
  
  div(id='after_gragh','The gragh show That Trunk Rural Roads represent The biggest ROads in traffic approximately 44% from total traffic  and Trunk Urabn also in Urban areas are congested 25.1%  ')
  
  
  )),






#End project Goals:




# about page:

tabItem(tabName="about",
        
        box(width=13,
        title = span(id="sp","About Us "), status = "primary", solidHeader = TRUE,collapsible = TRUE,
        
        includeHTML('www/about1.html')
        
        )),
        


  
  #End about page:------------->>>>>>>>


#Start MOdel: prediction model
  tabItem(tabName="model",
          box(width=35,
           title = strong("Prediction accident Rate over time"), status = "primary", solidHeader = TRUE,
           collapsible = TRUE,
           # Define UI for application 
           fluidPage(theme='style.css',
            
            # Application title
          
            titlePanel("Time Series Forecasting"),
            
            # Sidebar 
            
            sidebarLayout( 
             sidebarPanel(id="sidebar", width=3,    
                          sliderInput("bins_td", "Training Data Rate", min = 0.1, max = 1, value = 0.1),                          HTML('</br>'),

            sliderInput("bins_interval", "choose Year", min = 2005, max = 2025, value = 1),

              HTML('</br>'),
              uiOutput('dv'), 
              HTML('</br>'),
              uiOutput('iv'),
              HTML('</br>'),
            radioButtons('format', strong('Document format'), c('PDF', 'HTML', 'Word'), inline = TRUE),
            downloadButton('downloadReport')
              ),
             
             # main panel 
             
           
             
             
             
             mainPanel(width=9,
              tabsetPanel(id = 'dataset',
                          tabPanel("Data",
                                   
                                  numericInput("obs",label = strong("Number of observations to view"),9),
                                  
                                  box(width=6,
                                      title = strong("training Data"), status = "primary", solidHeader = TRUE,
                                      collapsible = TRUE,tableOutput("view")),
                                  
                                  box(width=6,
                                      title = strong("test Data"), status = "primary", solidHeader = TRUE,
                                      collapsible = TRUE,tableOutput("view1"))
                                  
                          ),
                          
                          
                          #--------------
                          tabPanel("Summary Statistics",
                                   
                                   
                                  # verbatimTextOutput("summary"),
                                  
                                  numericInput("ob1",label = strong("Number of observations to view"), 7),
                             box(width=10,
          title = strong("Error Estimation and Accuracy"), status = "primary", solidHeader = TRUE,ollapsible = TRUE,
                                      
                                      
                                     
                                      
                                      tableOutput('accuracy'),
                                      
                                      
                                      
                                      
                                      
                                      box(width=5,
                                          title = strong("Performence"), background = "light-blue",
                                          tableOutput("performence")
                                          
                                      )
                                      
                                      
                                      
                                      ),
                                  
                                 
                                  
                                 
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                   textInput("text_summary", label = "", value = "Enter Interpretation..")),
                          
                          tabPanel("Test Data",                   
                                   plotOutput("test_data"),
                                   
                                   
                                   
                                  
                                   
                                   
                                   textInput("text_hist_dv", label = "Interpretation", value = "Enter text..."),
                                   
                                   textInput("text_hist_iv", label = "Interpretation", value = "Enter text...")),                       
                          
                          tabPanel("Time series",                   
                                   plotOutput("scatter"),
                                   textInput("text_scatter", label = "Interpretation", value = "Enter text...")),  
                          
                          tabPanel("Forecasting",
                                   
                                   
                                   box(title=strong('Future observation Prediction Table'),
                                   tableOutput('table_interval')),
                                   
                                  
                                   numericInput("ob2",label = strong(""), 7),
                                   box(width=12,
                    title = strong(" predict New Future observation"), status = "primary", solidHeader = TRUE,
                                       collapsible = TRUE, plotOutput("interval"))),
                          
                          tabPanel("Model",                   
                                   verbatimTextOutput("model"),
                                   textInput("text_model", label = "Interpretation", value = "Enter text...")),
                          
                          tabPanel("Error",                   
                                   plotOutput("residuals_hist"),
                                   plotOutput("residuals_scatter"),
                                   textInput("text_residuals", label = "Interpretation", value = "Enter text..."))
                          
                          
                          
                          
                          
                          
              )                       
             ))
            
           ) 
           
           )#END box
           
           ),#End Regression tab


#start about
  tabItem( tabName="about",
         
           
                  
                   box( includeHTML(""),title = "About", status = "primary", solidHeader = TRUE,
                        collapsible = TRUE, width = "100%")
                   
                   ),#End about



  tabItem(tabName="gui", # start Gui
          
          box(width=12,
              title = "Data Visualizlization", status = "primary", solidHeader = TRUE,
              collapsible = TRUE,fluidPage(
                                                                                                                     
                                                                                                                     
                                                                                                                                   sidebarPanel(id="sidebar",width = 3,
                                                                                                                                  
                                                                                                                                  
                                                                                                                                  
                                                                                                                                  conditionalPanel(
                                                                                                                                   condition = "input.tabs=='ggplot' || input.tabs=='Plotly' ||
                                                                                                                                   input.tabs=='R-code'",
                                                                                                                                   h4("Create visualization"),
                                                                                                                                   selectInput(inputId = "Type",
                                                                                                                                               label = "Type of graph:",
                                                                                                                                               choices = c("Boxplot", "Density", "Dot + Error",
                                                                                                                                                           "Dotplot", "Histogram", "Scatter", "Violin"),
                                                                                                                                               selected = "Scatter"),
                                                                                                                                   selectInput("y_var", "Y-variable", choices = ""),
                                                                                                                                   conditionalPanel(
                                                                                                                                    condition = "input.Type!='Density' && input.Type!='Histogram'",
                                                                                                                                    selectInput("x_var", "X-variable", choices = "")
                                                                                                                                   ),
                                                                                                                                   selectInput("group", "Group (or colour)", choices = ""),
                                                                                                                                   selectInput("facet_row", "Facet Row", choices = ""),
                                                                                                                                   selectInput("facet_col", "Facet Column", choices = ""),
                                                                                                                                   conditionalPanel(
                                                                                                                                    condition = "input.Type == 'Boxplot' || input.Type == 'Violin' ||
                                                                                                                                    input.Type == 'Dot + Error'",
                                                                                                                                    checkboxInput(inputId = "jitter",
                                                                                                                                                  label = strong("Show data points (jittered)"),
                                                                                                                                                  value = FALSE)
                                                                                                                                   ),
                                                                                                                                   conditionalPanel(
                                                                                                                                    condition = "input.Type == 'Boxplot'",
                                                                                                                                    checkboxInput(inputId = "notch",
                                                                                                                                                  label = strong("Notched box plot"),
                                                                                                                                                  value = FALSE)
                                                                                                                                   ),
                                                                                                                                   conditionalPanel(
                                                                                                                                    condition = "input.Type == 'Density' || input.Type == 'Histogram'",
                                                                                                                                    sliderInput("alpha", "Opacity:", min = 0, max = 1, value = 0.8)
                                                                                                                                   ),
                                                                                                                                   conditionalPanel(
                                                                                                                                    condition = "input.Type == 'Histogram' || input.Type=='Dotplot'",
                                                                                                                                    numericInput("binwidth", "Binwidth:", value = 1)
                                                                                                                                   ),
                                                                                                                                   conditionalPanel(
                                                                                                                                    condition = "input.Type == 'Dotplot'",
                                                                                                                                    selectInput("dot_dir", "Direction stack:",
                                                                                                                                                choices = c("up", "down", "center", "centerwhole"),
                                                                                                                                                selected = "up")
                                                                                                                                   ),
                                                                                                                                   conditionalPanel(
                                                                                                                                    condition = "input.Type == 'Density' || input.Type == 'Violin'",
                                                                                                                                    sliderInput(inputId = "adj_bw",
                                                                                                                                                label = "Bandwidth adjustment:",
                                                                                                                                                min = 0.01, max = 2, value = 1, step = 0.1)
                                                                                                                                   ),
                                                                                                                                   conditionalPanel(
                                                                                                                                    condition = "input.Type == 'Scatter'",
                                                                                                                                    checkboxInput(inputId = "line",
                                                                                                                                                  label = strong("Show regression line"),
                                                                                                                                                  value = FALSE),
                                                                                                                                    conditionalPanel(
                                                                                                                                     condition = "input.line == true",
                                                                                                                                     selectInput("smooth", "Smoothening function",
                                                                                                                                                 choices = c("lm", "loess", "gam"))
                                                                                                                                    ),
                                                                                                                                    conditionalPanel(
                                                                                                                                     condition = "input.line == true",
                                                                                                                                     checkboxInput(inputId = "se",
                                                                                                                                                   label = strong("Show confidence interval"),
                                                                                                                                                   value = FALSE)
                                                                                                                                    )
                                                                                                                                   ),
                                                                                                                                   conditionalPanel(
                                                                                                                                    condition = "input.Type == 'Dot + Error'",
                                                                                                                                    selectInput("CI", "Confidence Interval:",
                                                                                                                                                choices = c("68% (1 SE)" = 1,
                                                                                                                                                            "90%" = 1.645,
                                                                                                                                                            "95%" = 1.96,
                                                                                                                                                            "99%" = 2.575),
                                                                                                                                                selected = 1.96)
                                                                                                                                   )
                                                                                                                     )
                                                                                                                     ),
                                                                                                                     
                                                                                                                     
                                                                                                                     #####################################
                                                                                                                     ########### OUPUT TABS ##############
                                                                                                                     #####################################
                                                                                                                     
                                                                                                                     mainPanel(width = 6,
                                                                                                                               tabsetPanel(type = "tabs",
                                                                                                                 
                                                                                                                                tabPanel("ggplot",
                                                                                                                                         mainPanel(
                                                                                                                                          downloadButton("download_plot_PDF.pdf",
                                                                                                                                                         "Download pdf of plot"),
                                                                                                                                          plotOutput("out_ggplot")),icon = icon("line-chart")),
                                                                                                                                tabPanel("Plotly", plotlyOutput("out_plotly"),icon = icon("bar-chart")),
                                                                                                                                tabPanel("R-code", verbatimTextOutput("out_r_code"),icon=icon("code")), id = "tabs")),

                                                                                                                                
                                                                                                                                
                                                                                                                                
                                                                                                                              
                                                                                                                     
                                                                                                                     
                                                                                                                     #####################################
                                                                                                                     ######### AESTHETICS TAB ############
                                                                                                                     #####################################
                                                                                                                     
                                                                                                                     conditionalPanel(
                                                                                                                      condition = "input.tabs=='ggplot' || input.tabs=='Plotly' ||
                                                                                                                      input.tabs=='R-code'",
                                                                                                                      sidebarPanel(id="sidebar",
                                                                                                                                   width = 3,
                                                                                                                                   h4("Change aesthetics"),
                                                                                                                                   tabsetPanel(
                                                                                                                                    tabPanel(
                                                                                                                                     "Text",
                                                                                                                                     checkboxInput(inputId = "label_axes",
                                                                                                                                                   label = strong("Change labels axes"),
                                                                                                                                                   value = FALSE),
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.label_axes == true",
                                                                                                                                      textInput("lab_x", "X-axis:", value = "label x-axis")
                                                                                                                                     ),
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.label_axes == true",
                                                                                                                                      textInput("lab_y", "Y-axis:", value = "label y-axis")
                                                                                                                                     ),
                                                                                                                                     checkboxInput(inputId = "add_title",
                                                                                                                                                   label = strong("Add title"),
                                                                                                                                                   value = FALSE),
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.add_title == true",
                                                                                                                                      textInput("title", "Title:", value = "Title")
                                                                                                                                     ),
                                                                                                                                     checkboxInput(inputId = "adj_fnt_sz",
                                                                                                                                                   label = strong("Change font size"),
                                                                                                                                                   value = FALSE),
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.adj_fnt_sz == true",
                                                                                                                                      numericInput("fnt_sz_ttl",
                                                                                                                                                   "Size axis titles:",
                                                                                                                                                   value = 12),
                                                                                                                                      numericInput("fnt_sz_ax",
                                                                                                                                                   "Size axis labels:",
                                                                                                                                                   value = 10)
                                                                                                                                     ),
                                                                                                                                     checkboxInput(inputId = "rot_txt",
                                                                                                                                                   label = strong("Rotate text x-axis"),
                                                                                                                                                   value = FALSE),
                                                                                                                                     checkboxInput(inputId = "adj_fnt",
                                                                                                                                                   label = strong("Change font"),
                                                                                                                                                   value = FALSE),
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.adj_fnt == true",
                                                                                                                                      selectInput("font", "Font",
                                                                                                                                                  choices = c("Courier",
                                                                                                                                                              "Helvetica",
                                                                                                                                                              "Times"),
                                                                                                                                                  selected = "Helvetica")
                                                                                                                                     )
                                                                                                                                    ),
                                                                                                                                    tabPanel(
                                                                                                                                     "Theme",
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.group != '.'",
                                                                                                                                      checkboxInput(inputId = "adj_col",
                                                                                                                                                    label = strong("Change colours"),
                                                                                                                                                    value = FALSE),
                                                                                                                                      conditionalPanel(
                                                                                                                                       condition = "input.adj_col",
                                                                                                                                       selectInput(inputId = "palet",
                                                                                                                                                   label = strong("Select palette"),
                                                                                                                                                   choices = list(
                                                                                                                                                    "Qualitative" = c("Accent",
                                                                                                                                                                      "Dark2",
                                                                                                                                                                      "Paired",
                                                                                                                                                                      "Pastel1",
                                                                                                                                                                      "Pastel2",
                                                                                                                                                                      "Set1",
                                                                                                                                                                      "Set2",
                                                                                                                                                                      "Set3"),
                                                                                                                                                    "Diverging" = c("BrBG",
                                                                                                                                                                    "PiYG",
                                                                                                                                                                    "PRGn",
                                                                                                                                                                    "PuOr",
                                                                                                                                                                    "RdBu",
                                                                                                                                                                    "RdGy",
                                                                                                                                                                    "RdYlBu",
                                                                                                                                                                    "RdYlGn",
                                                                                                                                                                    "Spectral"),
                                                                                                                                                    "Sequential" = c("Blues",
                                                                                                                                                                     "BuGn",
                                                                                                                                                                     "BuPu",
                                                                                                                                                                     "GnBu",
                                                                                                                                                                     "Greens",
                                                                                                                                                                     "Greys",
                                                                                                                                                                     "Oranges",
                                                                                                                                                                     "OrRd",
                                                                                                                                                                     "PuBu",
                                                                                                                                                                     "PuBuGn",
                                                                                                                                                                     "PuRd",
                                                                                                                                                                     "Purples",
                                                                                                                                                                     "RdPu",
                                                                                                                                                                     "Reds",
                                                                                                                                                                     "YlGn",
                                                                                                                                                                     "YlGnBu",
                                                                                                                                                                     "YlOrBr",
                                                                                                                                                                     "YlOrRd")),
                                                                                                                                                   selected = "set1")
                                                                                                                                      )
                                                                                                                                     ),
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.jitter",
                                                                                                                                      checkboxInput("adj_jitter",
                                                                                                                                                    strong("Change look jitter"), FALSE),
                                                                                                                                      conditionalPanel(
                                                                                                                                       condition = "input.adj_jitter",
                                                                                                                                       textInput("col_jitter", "Colour (name or RGB):",
                                                                                                                                                 value = "black"),
                                                                                                                                       numericInput("size_jitter", "Size:", value = 1),
                                                                                                                                       sliderInput("opac_jitter", "Opacity:",
                                                                                                                                                   min = 0, max = 1, value = 0.5, step = 0.01),
                                                                                                                                       sliderInput("width_jitter", "Width jitter:",
                                                                                                                                                   min = 0, max = 0.5, value = 0.25, step = 0.01)
                                                                                                                                      )
                                                                                                                                     ),
                                                                                                                                     checkboxInput("adj_grd",
                                                                                                                                                   strong("Remove gridlines"), FALSE),
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.adj_grd",
                                                                                                                                      checkboxInput("grd_maj",
                                                                                                                                                    strong("Remove major gridlines"), FALSE),
                                                                                                                                      checkboxInput("grd_min",
                                                                                                                                                    strong("Remove minor gridlines"), FALSE)
                                                                                                                                     ),
                                                                                                                                     selectInput("theme", "Theme",
                                                                                                                                                 choices = c("bw" = "theme_bw()",
                                                                                                                                                             "classic" = "theme_classic()",
                                                                                                                                                             "dark" = "theme_dark()",
                                                                                                                                                             "grey" = "theme_grey()",
                                                                                                                                                             "light" = "theme_light()",
                                                                                                                                                             "line_draw" = "theme_linedraw()",
                                                                                                                                                             "minimal" = "theme_minimal()"),
                                                                                                                                                 selected = "theme_bw()")
                                                                                                                                    ),
                                                                                                                                    tabPanel(
                                                                                                                                     "Legend",
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.group != '.'",
                                                                                                                                      radioButtons(inputId = "adj_leg",
                                                                                                                                                   label = NULL,
                                                                                                                                                   choices = c("Keep legend as it is",
                                                                                                                                                               "Remove legend",
                                                                                                                                                               "Change legend"),
                                                                                                                                                   selected = "Keep legend as it is"),
                                                                                                                                      conditionalPanel(
                                                                                                                                       condition = "input.adj_leg=='Change legend'",
                                                                                                                                       textInput("leg_ttl", "Title legend:",
                                                                                                                                                 value = "title legend"),
                                                                                                                                       selectInput("pos_leg", "Position legend",
                                                                                                                                                   choices = c("right",
                                                                                                                                                               "left",
                                                                                                                                                               "top",
                                                                                                                                                               "bottom"))
                                                                                                                                      )
                                                                                                                                     )
                                                                                                                                    ),
                                                                                                                                    tabPanel(
                                                                                                                                     "Size",
                                                                                                                                     checkboxInput("fig_size",
                                                                                                                                                   strong("Adjust plot size on screen"), FALSE),
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.fig_size",
                                                                                                                                      numericInput("fig_height", "Plot height (# pixels): ",
                                                                                                                                                   value = 480),
                                                                                                                                      numericInput("fig_width", "Plot width (# pixels):", value = 480)
                                                                                                                                     ),
                                                                                                                                     checkboxInput("fig_size_download",
                                                                                                                                                   strong("Adjust plot size for download"), FALSE),
                                                                                                                                     conditionalPanel(
                                                                                                                                      condition = "input.fig_size_download",
                                                                                                                                      numericInput("fig_height_download",
                                                                                                                                                   "Plot height (in cm):", value = 14),
                                                                                                                                      numericInput("fig_width_download",
                                                                                                                                                   "Plot width (in cm):", value = 14)
                                                                                                                                     )
                                                                                                                                    )
                                                                                                                                   ) # Close tabsetPanel
                                                                                                                      ) # Close sidebarPanel
                                                                                                                     ) # Close conditionalPanel
  ) # Close fluidPage
                                                                                  )
                                                                              
          
          ),#END GUI

  
  # Load datasets:
  tabItem(tabName = "Datasets",
          
          
          box(width=13,
              title = strong("Uploding Data"), status = "primary", solidHeader = TRUE,
              collapsible = TRUE, 
              
              fluidPage(theme='style.css',
                        
                        
                        
                        
                      
                        sidebarLayout(
                         sidebarPanel(id="sidebar",
                                      
                                      fileInput('file1', 'Choose traffic data:',
                                                accept=c('text/csv',
                                                         
                                               'application/xlsx',
                                                         'text/comma-separated-values,text/plain',
                                                         '.csv')),uiOutput("fromCol1"),
                                      
                                      
                                      fileInput('file2', 'Choose  accident data:',
                                                accept=c('text/csv',
                                                         'text/comma-separated-values,text/plain',
                                                         '.csv')),uiOutput("fromCol2")  
                                      
                         ),
                         
                         
                         mainPanel(width=3,
                                   
                                   
                                   tabsetPanel(
                                    id = 'dataset',
              tabPanel(id='d',"traffic",  DT::dataTableOutput("contents1", width = 650),icon = icon("table")),
              tabPanel("accidents",DT::dataTableOutput("contents2", width =650),icon = icon("table"))
                                    
                                    
                                   )
                                   
                         )
                        )
              ))
         
  )
#end Data
  ,
  # Second tab content
  tabItem(tabName = "Data-cleaning"
          
          
 )
 
 )
)

#
ui<-dashboardPage(skin="blue",header, sidebar, body)



#---------------------------------Server side----------------------------------------------------------


# server:

server <- function(input, output,session) {
 
 
 
 
 
 # ---------------------------------login module :------------------------------------
 
 values <- reactiveValues(authenticated = FALSE)
 
 # Return the UI for a modal dialog with data selection input. If 'failed' 
 # is TRUE, then display a message that the previous value was invalid.
 
 dataModal <- function(failed = FALSE) {
  modalDialog( id='login',
               
               
               
               tags$style(
                type = "text/css",
                "#login {color:#fff; background-color:black; width:100%}"
                
               ),     
               
               
               textInput("username", "Username:"),
               passwordInput("password", "Password:"),
               
              
               
               br(),
               #modalButton("Cancel"),
               actionButton("ok", strong("Login")),
               footer = tagList(
                
                
               )
               
               
               
  )
  
 }
 
 # Show modal when button is clicked.  
 # This `observe` is suspended only whith right user credential
 
 obs1 <- observe({
  showModal(dataModal())
 })
 
 # When OK button is pressed, attempt to authenticate. If successful,
 # remove the modal. 
 
 obs2 <- observe({
  req(input$ok)
  isolate({
   Username <- input$username
   Password <- input$password
  })
  Id.username <- which(my_username == Username)
  Id.password <- which(my_password == Password)
  if (length(Id.username) > 0 & length(Id.password) > 0) {
   if (Id.username == Id.password) {
    Logged <<- TRUE
    values$authenticated <- TRUE
    obs1$suspend()
    removeModal()
    
    
   } else {
    #values$authenticated <- FALSE 
    
    USER$pass <- "User name or password failed!"
    
    
   }     
  }
 })
 
 
 
 
 #----------------------------------End login Module---------------------------------
 
 
  

 
 # Notification
 
 
 observeEvent(input$show, {
  showNotification( strong("Please Uplode Data before Start Analyisis. "),type="error")
 })
 

 
 
 
 
 # close window
 observeEvent(input$close, {
  js$closeWindow()
  stopApp()
 })
                                      
  
  

 
 
 
 # to show image:
 output$image <- renderImage({
  return(list(
   src = "www/k.jpg",
   contentType = "image/jpeg",
   width = 1046,
   height = 785,
   alt = "science"
  ))
 }, deleteFile = FALSE)
 

 

 
 
 
 
 
 
 
 #-----------
 
 
 myData <- reactive({
  inFile <- input$file1
  if (is.null(inFile)) return(NULL)
  data <- read.csv(inFile$datapath, header = TRUE)
  

  
 })
 
 
 
 
 # training Data.
 trainingData<-reactive({
  
  inFile <- input$file1
  if (is.null(inFile)) return(NULL)
  data <- read.csv(inFile$datapath, header = TRUE)
  
  
  set.seed(100)  # setting seed to reproduce results of random sampling
  trainingRowIndex <- sample(1:nrow(data), input$bins_td*nrow(data))  # row indices for training data
  tra <- data[trainingRowIndex, ]  # model training data
  
  
 })
 
  
 
 #test Data
 
 testData<-reactive({
  
  inFile <- input$file1
  if (is.null(inFile)) return(NULL)
  data <- read.csv(inFile$datapath, header = TRUE)
  
  
  set.seed(100)  # setting seed to reproduce results of random sampling
  trainingRowIndex <- sample(1:nrow(data), input$bins_td*nrow(data))  # row indices for training data
  test  <- data[-trainingRowIndex, ]
  test
  
 })
 
 
 
 myData3<-myData
 
 myData2 <- reactive({
  inFile <- input$file2
  if (is.null(inFile)) return(NULL)
  data2 <- read.csv(inFile$datapath, header = TRUE)
  data2
  
 })
 
 output$fromCol1 <- renderUI({
  df <-myData()
  if (is.null(df)) return(NULL)
  
  items=names(df)
  names(items)=items
  selectInput("from", "varaibles name:",items)
  
 })
 output$contents1 <- DT::renderDataTable({
  myData()
  
  
 # DT::datatable(df[,items , drop = FALSE])
  
  
 },options = list(scrollX = TRUE))
 
 
 
 output$fromCol2 <- renderUI({
  df <-myData2()
  if (is.null(df)) return(NULL)
  
  items=names(df)
  names(items)=items
  selectInput("from", "varaibles name:",items)
  
 })
 output$contents2 <- DT::renderDataTable({
  myData2()
  

 },options = list(scrollX = TRUE))
 
 
 
 
 accidents<-reactive({
  
  
  
  
 })
 
 
 

 #--------------------Start Model-------------------------------------------
 
 

 
 # list of data sets


 
 

 
 output$dv = renderUI({
  selectInput('dv', strong('Dependent Variable'), choices = names(  trainingData()))
 })
 
 # independent variable
 output$iv = renderUI({
  selectInput('iv', strong('Independent Variable'), choices = names(  trainingData()))
 })
 
 # regression formula
 regFormula <- reactive({
  
  
 
  
  
 # fromula:
  as.formula(paste(input$dv, '~', input$iv))
 })
 
 
 # regression model
 model <- reactive({
  lm(regFormula(), data = trainingData())
 })
 
 
 
 
 
 
 # create graphics 
 
 # training data view 
 output$view <- renderTable({
  head(  trainingData()[,c(input$iv,input$dv)], n = input$obs)
 })
 
 
 # test data view 
 output$view1 <- renderTable({
  head(  testData()[,c(input$iv,input$dv)], n = input$obs)
 })
 
 
 # summary statistics
 output$summary <- renderPrint({
  summary(cbind(  trainingData()[input$dv],trainingData()[input$iv]))
 })
 
 
 
 
 # linear Model plot 
 output$scatter <- renderPlot({
  
 
  ggplot()+
  
   theme_bw()+ggtitle(' Time Series Data :downward trend time series')+
 scale_x_continuous( breaks=seq(1,nrow(trainingData()),length.out=10),labels=c("2005","2006","2007","2008","2009","2010",'2011',"2012","2013","2014"))+ 
  
 
   geom_line(aes(x=(trainingData()[,input$iv]-trainingData()[,input$iv])+(1:nrow(trainingData())),y=trainingData()[,input$dv] ),color="red")+
   
   xlab('Year')+ylab('Accident Rate')
   
   
 })
 

 
 
 
 # plot test Data
 output$test_data <- renderPlot({

  pred<-predict(model(),data=testData())
  
ggplot()+geom_smooth(aes(x=trainingData()[,input$iv],y= pred),color="red",method='gam',se=F)+
   
 geom_smooth(aes(x=testData()[,input$iv],y=testData()[,input$dv] ),color="blue",method='gam',se=F)+
   theme_bw()+scale_x_discrete(limits=testData()[,input$iv])+xlab('Year')+ylab('accident Rate')+
 
 ggtitle("Actual VS.predicted (Test data)")+labs(subtitle='Blue line:actual data.')
 

 
 })
 
 
 
 

output$value<-reactive({
 
 
 input$text
 
})
 


t<-reactive({
 

  newdata = data.frame(Year=bins_interval)
  predict.lm = predict(model(), newdata, interval="confidence",level=0.95)
 
 
 
})





 

 
 # confidence interval plot:
 

output$interval<-renderPlot({
 
 p<-predict(model(),data=data.frame(input$bins_interval),interval='confidence',level=0.95)
 ggplot()+
 geom_point(aes(x=input$bins_interval,y=p[1,'fit']),color='darkgreen',size=3)+
  
  

  xlab('Year')+geom_text(aes(x = input$bins_interval, y = p[1 ,'fit'],label=paste0(round(p[1 ,'fit'],1),"%")),vjust=-0.8,size=5,color="DarkGreen")+ylab("accident Rate")+
  
  scale_x_discrete(limits=c(2005:2020))

  
  
 
 
 
 
})



 output$table_interval<-renderTable({
  
  
  z<-predict(model(),data=data.frame(input$bins_interval),interval='confidence',level=0.95)
  
  FitRate<-z[,'fit']
  Min<-z[,'lwr']
  Max<-z[,'upr']
  
  
  flu<-data.frame(FitRate,Min,Max)

  head(flu,n=1)
  
 })
 
 
 

 #  Calculate Accuracy
 output$accuracy<-renderTable({
  
  
  actuals_preds <- data.frame(cbind(actual=testData()[,input$dv], predicted=predict(model(),data=testData()))) 

  head(actuals_preds,n=input$ob1)
  
} )  

 
 
 #-accuracy percentage:
 
 
 
 
 
 
 
 
 output$performence <- renderTable({
  
  
  
  

   actuals_preds <- data.frame(cbind(actual=testData()[,input$dv], predicted=predict(model(),data=testData())))
   Accuracy <- mean(apply(actuals_preds, 1, min) / apply(actuals_preds, 1, max))
   
   Error_Rate <- mean(abs((actuals_preds$predicted - actuals_preds$actual))/actuals_preds$actual)
   
   
   
  x<-data.frame(Accuracy,Error_Rate)
   
 
  
   head(x,n=1)
   
  
  
  
  
  
 })
 

 # Linear model
 output$model <- renderPrint({
  summary(model())
 })
 
 # residuals
 output$residuals_hist <- renderPlot({
  
  
  ggplot()+geom_bar(aes(x=model()$residuals),fill='blue',show.legend=F,position="dodge"
       ,width=1.5)+theme_bw()+
  
  #ggplot()+geom_density(aes(x=model()$residuals),color='red')
   ggtitle( paste(input$dv, '~', input$iv))+xlab("Residuals")
  
 })
 
 output$residuals_scatter <- renderPlot({
  plot(model()$residuals ~ trainingData()[,input$dv], xlab = input$dv, ylab = 'Residuals',col="darkgreen")
  abline(h = 0, lty = 3,col="blue") 
  box()
 })
 

 
 
 # download report
 output$downloadReport <- downloadHandler(
  filename = function() {
   paste('my-report', sep = '.', switch(
    input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
   ))
  },
  
  content = function(file) {
   src <- normalizePath('report.Rmd')
   owd <- setwd(tempdir())
   on.exit(setwd(owd))
   file.copy(src, 'report.Rmd')
   
   library(rmarkdown)
   out <- render('report.Rmd', switch(
    input$format,
    PDF = pdf_document(), HTML = html_document(), Word = word_document()
   ))
   file.rename(out, file)
  })
 
 
 # download cleaning data pdf file:
 output$report.pdf <- downloadHandler(
  filename = "final.pdf",
  content = function(file) {
   file.copy("www/final.pdf", file)
  },
  contentType = "application/pdf"
 )
 
 
 
 
 
 
 # view pdf linear regression
 output$view_regression <- renderUI({
  tags$iframe(style="height:1020px; width:100%", src="model.html")
 })
 
 
 # view pdf linear regression
 
 output$view_visual <- renderUI({
 tags$iframe(style="height:1020px; width:100%", src="visual.html")

 })
 # END reports------------------------------
 
# project Goals:
 
 
 
 # first Goal:-----------Start:
 output$first_1.1<-renderPlot({
  
  
  ukTraffic<- read.csv("www/ukTraffic.csv", header=TRUE, sep=",")
  
 
  
  ukTraffic<-mutate(ukTraffic,trafficvolume=ukTraffic$AllMotorVehicles*ukTraffic$LinkLength_miles*365) 
  ukTraffic<-mutate(ukTraffic,trafficvolume1=(ukTraffic$AllMotorVehicles+ukTraffic$PedalCycles)*ukTraffic$LinkLength_miles*365)
  
  tr<-group_by(ukTraffic,AADFYear)
  
  # summarize traffic volume by Year:
  trafficbyyears<- dplyr::summarize(tr,volumetraffic=sum(trafficvolume1),mean=mean(trafficvolume1))
  
  trafficbyyears<-mutate(trafficbyyears,percent=paste0(round(volumetraffic/sum(volumetraffic)*100,1),"%"))
  
 ggplot(data=trafficbyyears,aes(x=AADFYear,y=volumetraffic))+
   scale_x_discrete(limits = c(2005:2016))+
   
   labs(
    
    title="Annual Trafic volume by yeras in Britain",
    subtitle="increasing traffic volume through years",
    x="year",
    y="Annual traffic Volume(vichiles per miles)"
   )+theme_bw()+geom_smooth(se=F,method="gam")+geom_point(size=5,color="Tomato")+
   
   geom_text(aes(label=percent),vjust=-1.5,size=4,color="ForestGreen")
  

 })
 
 
 output$first_1.2<-renderPlot({
  
  accidents<- read.csv("www/accidents.csv", header=TRUE, sep=",")

  
  x<-group_by(accidents,Year)
  x1<- dplyr::summarize(x,accidents = n())
  x1<-mutate(x1,percent=paste0(round(accidents/nrow(x)*100,1),"%"))
  
  ggplot(data=x1,aes(x=factor(x1$Year),y=accidents,fill=factor(Year)),na.rm=F)+geom_bar(show.legend = FALSE,stat="identity")+
   
   
   labs(
    title=" The releation between yerars and number of accidents",
    subtitle="Total number of accidents in each year\n accident decrease in the last years with traffic volume",
    x="Year",
    y="Total number of accidents"
    
   )+ geom_text(aes(label=percent),vjust=-0.9,size=4,color="ForestGreen")
  
  
  
 })
 
 
 output$first_1.3<-renderPlot({
  
  accidents<- read.csv("www/accidents.csv", header=TRUE, sep=",")
  
  x<-group_by(accidents,Year)
  x1<- dplyr::summarize(x,accidents = n())
  x1<-mutate(x1,percent=paste0(round(accidents/nrow(x)*100,1),"%"))
  
  ggplot(data=x1,aes(x=Year,y=accidents),na.rm=F)+geom_smooth(method="gam",se=FALSE)+scale_x_discrete(limits = c(2005:2014))+geom_point(size=5,color="Tomato")+
   
   
   labs(
    title=" The releation between yerars and number of accidents",
    subtitle="Total number of accidents in each year\n accident decrease in the last years with traffic volume",
    x="Year",
    y="Total number of accidents"
    
   )+theme_bw()+
   
   geom_text(aes(label=percent),vjust=-0.9,size=4,color="DarkGreen")
  
 })
 
 # End first Goal:--------------------------------------
 
 #Start second Goal:
 
 output$second_2.1<-renderPlot({
  
  accidents<- read.csv("www/accidents.csv", header=TRUE, sep=",")
 
  w<-group_by(accidents,Urban_or_Rural_Area)
  rural<-dplyr::summarize(w,rate=n())
  rural<-mutate(rural,f=rate/nrow(w)*100)
  
  # plot:
  
  # rural and urban
  ggplot(data=rural,aes(x=Urban_or_Rural_Area,y=rate))+geom_point(size=4,color="Tomato")+
   
   geom_text(aes(label= paste0(round(f,1),"%")),vjust=-0.7,size=4)+
   
   labs(     
    
    x="Rural and urban area",
    y="total number of accidents",
    title="Differnce between Rural and urban in accidents rate % percentage"
    
   )+theme_bw()
  
 
 })
 
 
 
 # second gragh:
 
 
 output$second_2.2<-renderPlot({
  accidents<- read.csv("www/accidents.csv", header=TRUE, sep=",")
  
  q<-group_by(accidents,Year,Urban_or_Rural_Area)
  rural<-dplyr::summarize(q,rate=n())
  rural2<-mutate(rural,r2=paste0(round(rate/nrow(q)*100,1),"%"))
                   
  
  
  #Rural and urban by year.
  
  ggplot(data=rural2,aes(x=Year,y=rate,color=Urban_or_Rural_Area))+geom_point(size=4)+geom_smooth( method = 'loess',se=F)+
   
   geom_text(aes(label=r2),vjust=-0.7,size=4)+
   
   labs(
    
    x="Year",
    y="total number of accidents",
    title="differnce between Rural and urban in accidents by year.",
    color="Region"
    
   )+theme_bw()+scale_x_discrete(limits=seq(2005,2014,by=1))
  
  
  
 })
 
 
 
 # start  third Goal:------------------
 
  
 output$third_3.1<-renderPlot({
  ukTraffic<- read.csv("www/ukTraffic.csv", header=TRUE, sep=",")
  
  london<-filter(ukTraffic,ukTraffic$Region=="London")
  
  csr3<-group_by(london,AADFYear)
  
  allcrs<-dplyr::summarize(csr3,volume=sum(trafficvolume),mean=mean(trafficvolume))
  
  # compute percentage %
  allcrs<-mutate(allcrs,percent=paste0(round(mean/sum(allcrs$mean)*100,2),"%"))
  
  #plot
  
  ggplot(data = allcrs, aes(x = AADFYear,y=allcrs$volume)) + 
   geom_bar(stat="identity",fill="DarkCyan")+
   
   labs(
    
    title="  percentage of traffic volume for cars  throgh years",
    subtitle="for  ALL cars in London. ",
    x="Year",
    y="traffic volume(vechiles per mile)"
    
    
   )+theme_bw()+geom_text(aes(label=percent),vjust=-0.7,size=4,fontface="bold",color="DarkOliveGreen")+scale_x_discrete(limits=seq(2005,2016,by=1))
  
 })
 
 
 # second gragh:-----------------
 
 
 output$third_3.2<-renderPlot({
  
  
  ukTraffic<- read.csv("www/ukTraffic.csv", header=TRUE, sep=",")
  
  
  london<-filter(ukTraffic,ukTraffic$Region=="London")
  
  
  csr<-group_by(london,RoadCategory)
  allcartraffic<-dplyr::summarize(csr,volume=sum(trafficvolume),mean=mean(trafficvolume))
  allcartraffic<-mutate(allcartraffic,percent=paste0(round(mean/sum(allcartraffic$mean)*100,1),"%"))
  
  #plot
  
  ggplot(data = allcartraffic, aes(x = RoadCategory,y=allcartraffic$mean, fill =allcartraffic$RoadCategory)) + 
   geom_bar(stat="identity")+
   
   labs(
    
    title="  percentage of traffic volume in each Road by cars type ",
    subtitle="for cars without pedal cycles. ",
    x="Road type",
    y="traffic volume(vechiles permile)",
    fill="Road type"
    
   )+theme_bw()+geom_text(aes(label=percent),vjust=-0.7,size=4,fontface="bold",color="tomato1")
  
 })
 
 
 
 # End third Goal--------------------
 
 
 
 # start fourth goal------------
 output$fourth_4.1<-renderPlot({
  
  
  ukTraffic<- read.csv("www/ukTraffic.csv", header=TRUE, sep=",")
  
  change2<-group_by(ukTraffic,Region)
  areachange2<-dplyr::summarize(change2,volume=sum(trafficvolume1),mean=mean(trafficvolume1))
  areachange2<-mutate(areachange2,percent=paste0(round(mean/sum(areachange2$mean)*100,2),"%"))
  # plot
  
  
  ggplot(data = areachange2, aes(x=Region,y=mean,fill=Region)) + 
   geom_bar(stat="identity")+
   
   labs(
    
    title="  Which area traffic Volume change\nEache area traffic volume Rate:",
    subtitle="for All Regions. ",
    x="Region type",
    y="traffic volume(vechiles per mile)"
    
    
   )+theme_bw()+geom_text(aes(label=percent),vjust=-0.8,size=4,fontface="bold",color="DarkOliveGreen")
  
  
  
 })
 
 
 # end Fourth Goal:----------------------

 
 
 #start fifth Goal------------------------
 
 
 output$fifth_5.1<-renderPlot({
  
  ukTraffic<- read.csv("www/ukTraffic.csv", header=TRUE, sep=",")
  
  
  ur_roads<-filter(ukTraffic,RoadCategory%in%c("PU","PR","TU","TR"))
  
  ur<-group_by(ur_roads,RoadCategory)
  #summarize
  rualarban_rods<-dplyr::summarize(ur,mean=mean(trafficvolume1))
  rualarban_rods<-mutate(rualarban_rods,percent=paste0(round(mean/sum(rualarban_rods$mean)*100,2),"%"))
  # show summarize:
  
  #plot:
  
  bar <- ggplot(data = rualarban_rods,mapping = aes(x = RoadCategory, y =mean ,fill=RoadCategory)) + 
   geom_bar( stat="identity", width = 1,size=4) + 
   theme(aspect.ratio = 1) +
   labs(x = NULL, y = NULL,
        title="Differernce between  Rural And Urban  Roads:"
   )
  
  bar + coord_flip()
  bar + coord_polar()+geom_text(aes(label=percent),vjust=-0.5,size=4,color="black",fontface="bold")
  
  
  
 })
 
 
 
 # End fifth Goal:---------------------
 
 
 
 
 
 
 #----------------END Model-------------------------
 #-------------------------------          -----------------------------------
 #------------------------------- Start GUI::----------------------------------
 observe({
  nms <- names( myData3())
  # Make list of variables that are not factors
  nms_cont <- names(Filter(function(x) is.integer(x) ||
                            is.numeric(x) ||
                            is.double(x),
                           myData3()))
  
  # Make list of variables that are not factors
  nms_fact <- names(Filter(function(x) is.factor(x) ||
                            is.logical(x) ||
                            is.character(x),
                           myData3()))
  
  avail_all <- c("No groups" = ".", nms)
  avail_con <-
   if (identical(nms_cont, character(0)))
    c("No continuous vars available" = ".")
  else c(nms_cont)
  avail_fac <-
   if (identical(nms_fact, character(0)))
    c("No factors available" = ".")
  else c("No groups" = ".", nms_fact)
  
  updateSelectInput(session, "y_var", choices = avail_con)
  updateSelectInput(session, "x_var", choices = c("No x-var" = "' '", nms))
  updateSelectInput(session, "group", choices = avail_all)
  updateSelectInput(session, "facet_row",  choices = avail_fac)
  updateSelectInput(session, "facet_col",  choices = avail_fac)
 })
 
 
 #####################################
 ###### READ IN / GET DATA ###########
 #####################################
 

 #####################################
 ####### CREATE GRAPH-CODE ###########
 #####################################
 
 string_code <- reactive({
  
  # Variable used for how to deal with x/y in ggplot
  gg_x_y <- input$Type == "Histogram" ||
   input$Type == "Density"
  # Variable used for how to deal with colour/fill
  gg_fil <- input$Type == "Histogram" ||
   input$Type == "Density" ||
   input$Type == "Dotplot"
  
  # Only plot jitter when graphs allow them
  if (gg_fil || input$Type == "Scatter")
   jitt <- FALSE else jitt <- input$jitter
  
  p <- paste(
   "ggplot(df, aes(",
   if (gg_x_y) {
    "x = input$y_var"
   } else {
    "x = input$x_var, y = input$y_var"
   },
   if (input$group != "." && gg_fil) {
    ", fill = input$group"
   } else if (input$group != "." && !gg_fil) {
    ", colour = input$group"
   },
   ")) + ",
   if (input$Type == "Histogram")
    paste("geom_histogram(position = 'identity', alpha = input$alpha, ",
          "binwidth = input$binwidth)", sep = ""),
   if (input$Type == "Density")
    paste("geom_density(position = 'identity', alpha = input$alpha, ",
          "adjust = input$adj_bw)", sep = ""),
   if (input$Type == "Boxplot")
    "geom_boxplot(notch = input$notch)",
   if (input$Type == "Violin")
    "geom_violin(adjust = input$adj_bw)",
   if (input$Type == "Dotplot")
    paste("geom_dotplot(binaxis = 'y', binwidth = input$binwidth, ",
          "stackdir = 'input$dot_dir')", sep = ""),
   if (input$Type == "Dot + Error")
    paste("geom_point(stat = 'summary', fun.y = 'mean') +\n  ",
          "geom_errorbar(stat = 'summary', fun.data = 'mean_se', ", "
          width=0, fun.args = list(mult = input$CI))", sep = ""),
   if (input$Type == "Scatter")
    "geom_point()",
   if (input$Type == "Scatter" && input$line)
    "+ geom_smooth(se = input$se, method = 'input$smooth')",
   if (jitt)
    paste(" + geom_jitter(size = input$size_jitter, ",
          "alpha = input$opac_jitter, width = input$width_jitter, ",
          "colour = 'input$col_jitter')", sep = ""),
   sep = ""
  )
  
  # if at least one facet column/row is specified, add it
  facets <- paste(input$facet_row, "~", input$facet_col)
  if (facets != ". ~ .")
   p <- paste(p, "+ facet_grid(", facets, ")")
  
  # if labels specified
  if (input$label_axes)
   p <- paste(p, "+ labs(x = 'input$lab_x', y = 'input$lab_y')")
  
  # if title specified
  if (input$add_title)
   p <- paste(p, "+ ggtitle('input$title')")
  
  # if legend specified
  if (input$adj_leg == "Change legend")
   p <- paste(p, "+ labs(",
              if (gg_fil) "fill" else "colour",
              " = 'input$leg_ttl')",
              sep = "")
  
  # if colour legend specified
  if (input$adj_col)
   p <- paste(p, "+ scale_",
              if (gg_fil) "fill" else "colour",
              "_brewer(palette = 'input$palet')",
              sep = "")
  
  # If a theme specified
  p <- paste(p, "+", input$theme)
  
  # If theme features are specified
  if (input$adj_fnt_sz ||
      input$adj_fnt ||
      input$rot_txt ||
      input$adj_leg != "Keep legend as it is" ||
      input$adj_grd) {
   p <- paste(
    p,
    paste(
     " + theme(\n    ",
     if (input$adj_fnt_sz)
      "axis.title = element_text(size = input$fnt_sz_ttl),\n    ",
     if (input$adj_fnt_sz)
      "axis.text = element_text(size = input$fnt_sz_ax),\n    ",
     if (input$adj_fnt)
      "text = element_text(family = 'input$font'),\n    ",
     if (input$rot_txt)
      "axis.text.x = element_text(angle = 45, hjust = 1),\n    ",
     if (input$adj_leg == "Remove legend")
      "legend.position = 'none',\n    ",
     if (input$adj_leg == "Change legend")
      "legend.position = 'input$pos_leg',\n    ",
     if (input$grd_maj)
      "panel.grid.major = element_blank(),\n    ",
     if (input$grd_min)
      "panel.grid.minor = element_blank(),\n    ",
     ")",
     sep = ""
    ),
    sep = ""
   )
  }
  
  # Replace name of variables by values
  p <- str_replace_all(
   p,
   c("input\\$y_var" = input$y_var,
     "input\\$x_var" = input$x_var,
     "input\\$group" = input$group,
     "input\\$notch" = as.character(input$notch),
     "input\\$binwidth" = as.character(input$binwidth),
     "input\\$adj_bw" = as.character(input$adj_bw),
     "input\\$dot_dir" = as.character(input$dot_dir),
     "input\\$alpha" = as.character(input$alpha),
     "input\\$se" = as.character(input$se),
     "input\\$smooth" = as.character(input$smooth),
     "input\\$CI" = as.character(input$CI),
     "input\\$size_jitter" = as.character(input$size_jitter),
     "input\\$width_jitter" = as.character(input$width_jitter),
     "input\\$opac_jitter" = as.character(input$opac_jitter),
     "input\\$col_jitter" = as.character(input$col_jitter),
     "input\\$lab_x" = as.character(input$lab_x),
     "input\\$lab_y" = as.character(input$lab_y),
     "input\\$title" = as.character(input$title),
     "input\\$palet" = as.character(input$palet),
     "input\\$fnt_sz_ttl" = as.character(input$fnt_sz_ttl),
     "input\\$fnt_sz_ax" = as.character(input$fnt_sz_ax),
     "input\\$font" = as.character(input$font),
     "input\\$leg_ttl" = as.character(input$leg_ttl),
     "input\\$pos_leg" = as.character(input$pos_leg))
  )
  # Creates well-formatted R-code for output
  p <- str_replace_all(p, ",\n    \\)", "\n  \\)")
  
  p
 })
 
 
 #####################################
 ###### GRAPHICAL/TABLE OUTPUT #######
 #####################################
 
 output$out_table <- renderDataTable(
  myData()
 )
 
 width <- reactive ({ input$fig_width })
 height <- reactive ({ input$fig_height })
 width_download <- reactive ({ input$fig_width_download })
 height_download <- reactive ({ input$fig_height_download })
 
 output$out_ggplot <- renderPlot(width = width,
                                 height = height, {
                                  # evaluate the string RCode as code
                                  df <-  myData()
                                  p <- eval(parse(text = string_code()))
                                  p
                                 })
 
 output$out_plotly <- renderPlotly({
  # evaluate the string RCode as code
  df <-  myData()
  p <- eval(parse(text = string_code()))
  ggplotly(p)
 })
 
 #####################################
 #### GENERATE R-CODE FOR OUTPUT #####
 #####################################
 
 output$out_r_code <- renderText({
  
  gg_code <- string_code()
  gg_code <- str_replace_all(gg_code, "\\+ ", "+\n  ")
  
  paste(
   "## You can use the below code to generate the graph.\n",
   "## Don't forget to replace the 'df' with the name\n",
   "## of your dataframe\n\n",
   "# You need the following package(s):\n",
   "library(\"ggplot2\")\n\n",
   "# The code below will generate the graph:\n",
   "graph <- ",
   gg_code,
   "\ngraph\n\n",
   "# If you want the plot to be interactive,\n",
   "# you need the following package(s):\n",
   "library(\"plotly\")\n",
   "ggplotly(graph)\n\n",
   "# If you would like to save your graph, you can use:\n",
   "ggsave('my_graph.pdf', graph, width = ",
   width_download(),
   ", height = ",
   height_download(),
   ", units = 'cm')",
   sep = ""
  )
  
 })
 
 #####################################
 #### GENERATE R-CODE FOR OUTPUT #####
 #####################################
 
 output$download_plot_PDF.pdf <- downloadHandler(
  filename <- function() {
   paste("Figure_ggplotGUI_", Sys.time(), ".pdf", sep = "")
  },
  content <- function(file) {
   df <-  myData()
   p <- eval(parse(text = string_code()))
   ggsave(file, p, width = width_download(),
          height = height_download(), units = "cm")
  },
  contentType = "application/pdf" # MIME type of the image
 )
 
 # End R-session when browser closed
 session$onSessionEnded(stopApp)
 #--------------------------------End GUI::::
 
}

shinyApp(ui, server)




