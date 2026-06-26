source("tools/-setup.r") #Setup Script
source("tools/box_authentication.R")

library(terra) #package for handling rasters
#install.packages("tidyterra") install this package if needed
library(dplyr)
#library(tidyterra) #package for plotting rasters
library(ggplot2)


box_ls('392885596000') #Checking out the contents of the Landscape Scenario Planning Tool
box_fetch(
  dir_id = '392885596000', #putting in tiff file id
  local_dir = file.path('data'), #setting in the data folder
  recursive = TRUE,
  overwrite = FALSE,
  delete = FALSE
)
#Downloading All Files in the LSPT Folder
### Read the raster files using rast function once the list pieces are parsed out.
# This looks for any file ending in .tif or .tiff
raster_file <- list.files(path= 'data', pattern = "\\.tiff?$", full.names = TRUE)
print(raster_file)

raster_list <- lapply(raster_file, rast)
raster_list[1] #carbon_storage_hist
raster_list[2] #carbon_storage_mod
raster_list[3] #peat_thickness_hist
raster_list[4] #peat_thickness_mod

carbon_storage_hist<-rast(raster_list[1])
plot(carbon_storage_hist)
carbon_storage_mod<-rast(raster_list[2])
plot(carbon_storage_mod)
peat_thickness_hist<-rast(raster_list[3])
plot(peat_thickness_hist)
peat_thickness_mod<-rast(raster_list[4])
plot(peat_thickness_mod)

# Export rasters to Box
# Temporarily store raster
temp_raster_path <- file.path(tempdir(), "carbon_storage_hist.tif")
writeRaster(carbon_storage_hist, temp_raster_path, overwrite = TRUE)

# Define your Box folder number (ID) and upload the file
folder_id_number <- "379716878316" # Replace with your actual Box folder ID
box_ul(file = temp_raster_path, dir_id = 379716878316)

# Temporarily store raster
temp_raster_path <- file.path(tempdir(), "carbon_storage_mod.tif")
writeRaster(carbon_storage_mod, temp_raster_path, overwrite = TRUE)

# Define your Box folder number (ID) and upload the file
folder_id_number <- "379716878316" # Replace with your actual Box folder ID
box_ul(file = temp_raster_path, dir_id = 379716878316)

# Temporarily store raster
temp_raster_path <- file.path(tempdir(), "peat_thickness_hist.tif")
writeRaster(peat_thickness_hist, temp_raster_path, overwrite = TRUE)

# Define your Box folder number (ID) and upload the file
folder_id_number <- "379716878316" # Replace with your actual Box folder ID
box_ul(file = temp_raster_path, dir_id = 379716878316)

# Temporarily store raster
temp_raster_path <- file.path(tempdir(), "peat_thickness_mod.tif")
writeRaster(peat_thickness_mod, temp_raster_path, overwrite = TRUE)

# Define your Box folder number (ID) and upload the file
folder_id_number <- "379716878316" # Replace with your actual Box folder ID
box_ul(file = temp_raster_path, dir_id = 379716878316)
