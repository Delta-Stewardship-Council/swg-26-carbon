source("tools/-setup.r") #Setup Script
source("tools/box_authentication.R")
box_ls('392885596000') #Checking out the contents of the Landscape Scenario Planning Tool
box_fetch(
  dir_id = '392885596000', #putting in tiff file id
  local_dir = file.path('data'), #setting in the data folder
  recursive = TRUE,
  overwrite = FALSE,
  delete = FALSE
)
#Downloading All Files in the LSPT Folder
