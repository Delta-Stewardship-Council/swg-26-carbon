source("tools/-setup.r") #Setup Script
source("tools/box_authentication.R")
box_ls('392885596000') #Checking out the contents of the Landscape Scenario Planning Tool
box_fetch(
  dir_id = '392885596000', #putting in tiff file id
  local_dir = file.path('data/LSPT'), #setting in the data folder
  recursive = TRUE,
  overwrite = FALSE,
  delete = FALSE
)
#Downloading All Files in the LSPT Folder
### Read the raster files
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
