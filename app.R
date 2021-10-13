library(shiny)
library(dplyr)
library(config)
library(mongolite)
library(here)

source(here::here("R/app_text.R"))
source(here::here("R/generate_modal.R"))

# Configure MongoDB
Sys.setenv(R_CONFIG_ACTIVE =  "default")
config <- config::get(file = here::here("config.yml"))

ui <- shiny::fluidPage(
  
  title = "Webinar: Model Risk Management", 
  
  shiny::fluidRow(
    
    shiny::br(), 
    
    shiny::column(
      width = 6, 
      
      shiny::div(
        class = "jumbotron", 
        shiny::h3("Webinar on October 27, 2021, at 12:00pm EST"), 
        shiny::h2(
          shiny::strong("Model Risk Management")
        ), 
        registration_txt()
      )
      
    ), 
    
    shiny::column(
      width = 6, 
      
      shiny::br(), 
      
      shiny::tags$img(
        class = "thumbnail img-responsive", 
        src = "ka_logo.jpg", 
        # style = "width:200px;"   # image size is responsive up to 200px
      ) %>% 
        shiny::a(
          href = "https://www.ketchbrookanalytics.com/", 
          target = "_blank"
        ), 
      
      shiny::br(), 
      
      shiny::h3("Please Register Using the Fields Below:"), 
      
      shiny::textInput(
        inputId = "first_name", 
        label = "First Name *", 
        width = '100%'
      ), 
      
      shiny::textInput(
        inputId = "last_name", 
        label = "Last Name *", 
        width = '100%'
      ), 
      
      shiny::textInput(
        inputId = "email", 
        label = "Email *", 
        width = '100%'
      ), 
      
      shiny::textInput(
        inputId = "org", 
        label = "Organization", 
        width = '100%'
      ),
      
      shiny::actionButton(
        class = "btn btn-primary btn-lg", 
        inputId = "register_btn", 
        label = "Register", 
        icon = shiny::icon("pen")
      )
      
    )
    
  )
  
)

server <- function(input, output, session) {
  
  shiny::observeEvent(input$register_btn, {
    
    process_registration(
      first_name_txt = input$first_name, 
      last_name_txt = input$last_name, 
      email_txt = input$email, 
      org_txt = input$org, 
      creds = config
    )
    
  })
  
}

shiny::shinyApp(ui, server)