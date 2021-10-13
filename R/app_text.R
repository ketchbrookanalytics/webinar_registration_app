registration_txt <- function() {
  
  font_size_html <- "font-size:21px"
  
  shiny::tagList(
    shiny::span(
      shiny::p(
        paste(
          "
          Predictive models are all the rage these days: whether by classical 
          statistics, machine learning or AI, models are transforming the way we 
          do business. While building the model is exciting, it's only half the 
          battle. Once our model is deployed, we must ensure that it:
          "
        )
      ), 
      shiny::tags$ul(
        shiny::tags$li(
          style = font_size_html, 
          "continues to have fidelity with a constantly changing world"
        ), 
        shiny::tags$li(
          style = font_size_html, 
          "has proper monitoring systems in place"
        ), 
        shiny::tags$li(
          style = font_size_html, 
          "is ethically sound"
        ), 
        shiny::tags$li(
          style = font_size_html, 
          "... and much more!"
        ), 
      )
    ), 
    shiny::span(
      shiny::p(
        paste(
          "
        All of these concepts that wrap around the model are part of a framework 
        referred to as
        "
        ), 
        shiny::em("Model Risk Management.")
      )
    ), 
    shiny::p(
      shiny::strong(
        paste(
        "
        In this webinar, we will discuss what should be included in your Model 
        Risk Management framework, and provide an overview of the most common 
        tools that can help.
        "
        )
      )
    )
  )
  
}