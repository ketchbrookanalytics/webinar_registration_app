


mongo_connect <- function(collection, database, 
                          host = config$host, 
                          username = config$username, 
                          password = config$password) {
  
  mongolite::mongo(
    collection = collection, 
    url = stringr::str_glue("mongodb+srv://{username}:{password}@{host}/{database}")
  )
  
}


send_data <- function(data) {
  
  mongo_connection <- mongo_connect(
    collection = "mrm_webinar_registration", 
    database = "marketing"
  )
  
  mongo_connection$insert(data)
  
}


process_registration <- function(first_name_txt, last_name_txt, email_txt, org_txt) {
  
  title <- "Thank You!"
  text <- paste(
    "
    We can't wait for you to join us on 10/27.  Please check your email for 
    an invitation with the event details in the next 24 hours. 
    "
  )
  
  valid_flag <- TRUE

  if (nchar(first_name_txt) == 0) {
    
    title <- "Oops!"
    text <- "Please enter your First Name in the form."
    valid_flag <- FALSE
    
  } else {
    
    if (nchar(last_name_txt) == 0) {
      
      title <- "Oops!"
      text <- "Please enter your Last Name in the form."
      valid_flag <- FALSE
      
    } else {
      
      if ((nchar(email_txt) == 0) | (!grepl("@", email_txt))) {
        
        title <- "Oops!"
        text <- "Please enter a valid Email Address in the form."
        valid_flag <- FALSE
        
      }
      
    }
    
  }
  
  if (valid_flag) {
    
    user_data <- tibble::tibble(
      first_name = first_name_txt, 
      last_name = last_name_txt, 
      email_address = email_txt, 
      organization_name = org_txt, 
      event_name = "Model Risk Management Webinar"
    )
    
    send_data(data = user_data)
    
  }
  
  shiny::modalDialog(
    title = title, 
    text, 
    easyClose = FALSE
  ) %>% 
    shiny::showModal()
  
}
