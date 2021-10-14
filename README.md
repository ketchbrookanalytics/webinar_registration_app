![](www/ka_logo.jpg)

<hr>

# Webinar Registration App

This repository contains materials associated with the R Shiny web app used to process registrant's information as they signed up for Ketchbrook Analytics' **Model Risk Management** webinar on 2021-10-27.

## Purpose

After getting frustrated with cost an unwanted features from paid webinar hosting/registration services, I decided to create my own Shiny app.  This was also a chance for me to POC something that I knew I *could* do, but hadn't attempted yet: write out inputs from the application to a *cloud* database. 

## Setup

If you want to try this yourself, you will need to do a few things first:

1. Clone this repository to your local machine, and install the package dependencies with `renv::restore()` (Note: you need run `install.packages("renv")` first if you do not already have the [{renv}](https://rstudio.github.io/renv/articles/renv.html) package installed)
3. Set up a MongoDB Atlas database, using this [Getting Started Guide](https://docs.atlas.mongodb.com/getting-started/)
    + note that you will need to ensure that the IP address of where your app lives is whitelisted by your Mongo database cluster.
4. Create a **config.yml* YAML file at the root of this repository, containing the credentials for connecting your Shiny app to your MongoDB Atlas database; you can get your credentials from MongoDB by following [these instructions](https://docs.atlas.mongodb.com/tutorial/connect-to-your-cluster/#connect-to-your-atlas-cluster), and an example of what that file should look like can be found in [examples/config.yml](examples/config.yml)
5. Edit the [app.R](app.R) script and the custom functions within the [R/](R/) directory to customize the app for your own use case

## Under the Hood

While this Shiny app is very small [app.R](app.R) is barely 100 lines of code, the workhorse function that moves the data entered into the UI is called [process_registration()](R/generate_modal.R#L36).

One of my favorite components of the app is the stop-gap measures in place within [process_registration()](R/generate_modal.R#L36), which alter the message the user sees in the pop-up modal based upon whether or not they entered valid/complete data in the UI.

## Want to Learn More?

Get in touch with us at [info@ketchbrookanalytics.com](mailto:info@ketchbrookanalytics.com)! We offer R & Shiny training & education services, as well as general data science consulting.
