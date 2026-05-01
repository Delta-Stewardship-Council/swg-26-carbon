# Script for pulling in data from Box

# Step 1: Save data in Box ----
## Note: remember to document the data you are using in our data inventory

# Step 2: Enable API access within Box ----
## Follow these steps: https://nceas-learning-hub.github.io/2026_delta_week1/s06_lecture_data_mgmt_discovery.html#bonus-load-data-from-box-into-r

# Step 3: Connect Box to your local computer

## Install and configure the boxr package
#install.packages("boxr")
library(boxr)

## Step 2.1: Now add in your unique Box authentication IDs to the .Renviron file
## Note: each our unique authentication IDs can be stored in the .Renviron file  so you don't have look it up each time
usethis::edit_r_environ()

## Step 2.2: Try to authenticate box!
box_auth()

## If this is your first time connecting to box, you may get a message in the console that says "Please enter your box client id." Paste your CLIENT ID and then hit 'enter'. 
## Next, it will ask you to ask you to "Please enter your box client secret". Paste your CLIENT SECRET and then hit 'enter'.
## A window will pop up. Click 'Open' Box on your web browser and then select 'Grant Access'.
## Now you should be good to go in the future, where you can just run box_auth() and it will use the .Renviron file to authenticate

## If you have done this before, you should see the following messages in your console: 
### Using `BOX_CLIENT_ID` from environment
### Using `BOX_CLIENT_SECRET` from environment
### boxr: Authenticated using OAuth2 as < FIRST LAST > (email, id: ##########)

# Step 4: Download data from Box

## Function to list folders in your Box drive
box_ls()

# Search for the base project folder, and return it as a data frame
response <- box_search_folders("2026_DELTA_SYNTHESIS_WORKGROUP")
base_folder <- as.data.frame(response)[c("name", "type", "size", "id")]

# Using the base folder id, list the contents of that folder
as.data.frame(response)[c("name", "type", "size", "id")]

