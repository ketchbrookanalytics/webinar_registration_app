library(shiny)
library(dplyr)
library(config)
library(mongolite)
library(here)

# Import custom functions
source(here::here("R/app_text.R"))
source(here::here("R/generate_modal.R"))

# Configure MongoDB
Sys.setenv(R_CONFIG_ACTIVE =  "default")
config <- config::get(file = here::here("config.yml"))

# UI ----
ui <- shiny::fluidPage(
  
  title = "Webinar: Model Risk Management", 
  
  shiny::fluidRow(
    
    shiny::br(), 
    
    # Build informational panel on left side of the page
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
    
    # Build out the right side of the page...
    shiny::column(
      width = 6, 
      
      shiny::br(), 
      
      # Add KA logo with hyperlink to website 
      shiny::tags$img(
        class = "thumbnail img-responsive", 
        src = "ka_logo.jpg", 
      ) %>% 
        shiny::a(
          href = "https://www.ketchbrookanalytics.com/", 
          target = "_blank"
        ), 
      
      shiny::br(), 
      
      shiny::h3("Please Register Using the Fields Below:"), 
      
      # Build text input boxes for entering name, email, and organization
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
      
      # Build "Register" button to take server action on click
      shiny::actionButton(
        class = "btn btn-primary btn-lg", 
        inputId = "register_btn", 
        label = "Register", 
        icon = shiny::icon("pen")
      )
      
    )
    
  )
  
)

# SERVER ----
server <- function(input, output, session) {
  
  # On "Register" button-click, process registration using custom function
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