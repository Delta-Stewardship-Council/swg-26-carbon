---
title: "Read Hydrofocus Maps"
format: html
author: Diana Zapata
---

## Setup
source("tools/-setup.r") # This sources functions within the setup script to make sure we all have the same folder structure
source("tools/box_authentication.R") # This will authenticate your Box connection to be able to access data. info on specific Box folder IDs is also in this script for your reference


### Download packages
install.packages(c("boxr", "sf", "terra"))
library(boxr)
library(sf)
library(terra)

### Datra folder codes
# box_ls("375552738580") # Data folder
# box_ls("379716945014") # rawdata
# box_ls("392886560802") # Hydrofocus

### Download data
 # 1. Define your Box folder ID
deverel_box_folder <- "392886560802"

# 2. Create a local temporary directory to store the spatial files
local_dir <- tempdir()

# 3. Download the entire folder contents from Box
box_fetch(
    dir_id = deverel_box_folder, 
    local_dir = local_dir, 
    overwrite = TRUE
)

###
# 1. Find the raster file name in your temporary directory
# This looks for any file ending in .tif or .tiff
raster_file <- list.files(local_dir, pattern = "\\.tiff?$", full.names = TRUE)

# Print it to make sure R found it
print(raster_file)

# Load them as a collection list instead of a single stack
raster_list <- lapply(raster_file, rast)

# If they are adjacent tiles, you can merge them into one giant map:
my_mosaic <- do.call(mosaic, raster_list)
plot(my_mosaic)





