###################################################
### Script for reading Hydrofocus maps from Box ###
###################################################

### ==========================================
### 1) Setup & Package Management
### ==========================================
source("tools/-setup.r")           # Establishes shared folder structures
source("tools/box_authentication.R") # Authenticates Box connection

# Function to safely install missing packages without re-installing existing ones
required_packages <- c("boxr", "sf", "terra", "readr", "dplyr", "tidyr", 
                       "here", "vctrs", "ggplot2", "leaflet", "ggspatial", "prettymapr")

missing_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if(length(missing_packages) > 0) {
    install.packages(missing_packages)
}

# Load libraries
library(boxr)
library(sf)
library(terra)
library(readr)
library(dplyr)
library(tidyr)
library(here)
library(ggplot2)
library(ggspatial)

### ==========================================
### A. Raster - Download & Read Files
### ==========================================

# Define Box folder ID & local directory
dev_folder_id <- "392886560802"
dev_dir <- here::here('data/delta_hydrofocus')

# Handle folder creation safely
if(!dir.exists(dev_dir)) {
    dir.create(dev_dir, recursive = TRUE)
}

# List all items inside the Box folder
box_contents <- as.data.frame(box_ls(dev_folder_id))

# Filter for files ending in .tif or .tiff (case-insensitive)
tif_files <- box_contents %>% 
  filter(type == "file" & grepl("\\.tiff?$", name, ignore.case = TRUE))

print(paste("Found", nrow(tif_files), ".tif files to download."))

# Loop through and download ONLY the .tif files
if (nrow(tif_files) > 0) {
    for (i in 1:nrow(tif_files)) {
        box_dl(
            file_id = tif_files$id[i],
            local_dir = dev_dir,
            overwrite = TRUE
        )
    }
} else {
    stop("No .tif files were found in the specified Box folder.")
}

# Identify and load the locally downloaded files
raster_files <- list.files(dev_dir, pattern = "\\.tiff?$", full.names = TRUE, ignore.case = TRUE)
raster_list <- lapply(raster_files, rast)

print(paste("Successfully loaded", length(raster_list), "raster layers into R."))

# Look into the raster layers details and ensure they are loaded correctly
raster_list[1] # delta_fluxes_tCO2e_ac
raster_list[2] # depth_to_water_table_m
raster_list[3] # organic_soil_tickness

# Plots: Loop through the list and plot each raster individually
for (i in seq_along(raster_list)) {
    
    # Extract just the file name from the full path to use as a title
    file_title <- basename(raster_files[i])
    
    # Plot the spatRaster object
    plot(raster_list[[i]], main = file_title)
}






### ==========================================
### B. Shapefile - Download & Read Files
### ==========================================
out_dir <- here::here('data/soils_delta')

# Check if directory exists; if not, create it and pull data
if(!dir.exists(out_dir)) {
    dir.create(out_dir, recursive = TRUE)
    
    box_folder_id <- "392994519065" #392894519065 worked for me
    box_fetch(
        dir_id = box_folder_id, 
        local_dir = out_dir,
        overwrite = TRUE
    )
}

### ==========================================
### 3. Spatial Analysis & Visualization
### ==========================================

# Read the shapefile
delta_soils_sf <- read_sf(here::here('data/soils_delta/delta_soils_20210714_3717_v4.shp'))

# Verify Coordinate Reference System (CRS)
print(st_crs(delta_soils_sf))

# Plot soil organic matter (fom2)
ggplot(data = delta_soils_sf) +
  geom_sf(aes(fill = fom2)) +
  scale_fill_viridis_c(option = "plasma") + 
  theme_minimal() +
  labs(
    title = "Soil Organic Matter in the Delta (SSURGO)", 
    fill = "Percentage",
    caption = paste("CRS:", st_crs(delta_soils_sf)$epsg)
  )


### ==========================================
### 2) Combining files for analysis
### ==========================================
