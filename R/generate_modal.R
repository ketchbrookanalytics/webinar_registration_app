


# Function to connect to a specific MongoDB Atlas database collection
mongo_connect <- function(collection, database, creds) {
  
  mongolite::mongo(
    collection = collection, 
    url = stringr::str_glue(
      "mongodb+srv://{creds$username}:{creds$password}@{creds$host}/{database}"
    )
  )
  
}


# Function to insert a new record into a specific MongoDB Atlas database 
# collection
send_data <- function(data, creds) {
  
  # Build the connection to the database collection
  mongo_connection <- mongo_connect(
    collection = "mrm_webinar_registration", 
    database = "marketing", 
    creds = creds
  )
  
  # Using the connection, insert values from a data frame as new record(s) 
  mongo_connection$insert(data)
  
}


# Given character strings containing "First Name", "Last Name", "Email", and 
# "Organization", save the user's inputs on the form to a database
process_registration <- function(first_name_txt, last_name_txt, email_txt, org_txt, 
                                 creds) {
  
  # To start, assume the entries in the form are complete & valid
  valid_flag <- TRUE
  title <- "Thank You!"
  text <- paste(
    "
    We can't wait for you to join us on 10/27.  Please check your email for 
    an invitation with the event details in the next 24 hours. 
    "
  )

  # If the "First Name" in the form is empty...
  if (nchar(first_name_txt) == 0) {
    
    # ... overwrite the modal title & text, and store the entry as invalid 
    valid_flag <- FALSE
    title <- "Oops!"
    text <- "Please enter your First Name in the form."
    
    
  } else {
    
    # If the "Last Name" in the form is empty...
    if (nchar(last_name_txt) == 0) {
      
      # ... overwrite the modal title & text, and store the entry as invalid 
      valid_flag <- FALSE
      title <- "Oops!"
      text <- "Please enter your Last Name in the form."
      
      
    } else {
      
      # If the "Email" in the form is empty or doesn't contain an "@" 
      # character...
      if ((nchar(email_txt) == 0) | (!grepl("@", email_txt))) {
        
        # ... overwrite the modal title & text, and store the entry as invalid 
        valid_flag <- FALSE
        title <- "Oops!"
        text <- "Please enter a valid Email Address in the form."
        
        
      }
      
    }
    
  }
  
  
  # If the entries in the form are complete & valid... 
  if (valid_flag) {
    
    # ... build a data frame from the user's text inputs
    user_data <- tibble::tibble(
      first_name = first_name_txt, 
      last_name = last_name_txt, 
      email_address = email_txt, 
      organization_name = org_txt, 
      event_name = "Model Risk Management Webinar"
    )
    
    # then send the data to the MongoDB as a new record in the database 
    # collection
    send_data(
      data = user_data, 
      creds = creds
    )
    
  }
  
  # Display a modal to the user, indicating either successful processing of 
  # their entry, or a warning about an incomplete field
  shiny::modalDialog(
    title = title, 
    text, 
    easyClose = FALSE
  ) %>% 
    shiny::showModal()
  
}
