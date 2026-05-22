rename_file_from_data <- function(file_id) {
  
  # Download file content from Box
  tmp <- tempfile(fileext = ".csv")
  box_dl(file_id, local_dir = dirname(tmp), overwrite = TRUE)
  
  # Read and extract attributes
  df <- read_csv(tmp, show_col_types = FALSE)
  
  # Check expected columns exist
  required_cols <- c("region", "year", "data_type")
  missing <- setdiff(required_cols, names(df))
  if (length(missing) > 0) {
    warning(glue::glue("File {file_id} missing columns: {paste(missing, collapse = ', ')} — skipping"))
    return(invisible(NULL))
  }
  
  # Build new name from first row values
  region    <- tolower(gsub(" ", "_", df$region[1]))
  year      <- as.character(df$year[1])
  data_type <- tolower(gsub(" ", "_", df$data_type[1]))
  new_name  <- paste0(region, "_", year, "_", data_type, ".csv")
  
  # Rename in Box
  box_update_object(file_id, name = new_name)
  message("Renamed file ", file_id, " → ", new_name)
}

rename_files_in_folder <- function(folder_id, dry_run = TRUE) {
  
  # List files in folder
  files <- box_ls(folder_id) |> 
    as.data.frame() |> 
    filter(type == "file", grepl("\\.csv$", name))
  
  for (i in seq_len(nrow(files))) {
    file_id   <- files$id[i]
    file_name <- files$name[i]
    
    if (dry_run) {
      message("DRY RUN — would process: ", file_name, " (id: ", file_id, ")")
    } else {
      rename_file_from_data(file_id)
    }
  }
}

# Preview first, then set dry_run = FALSE to execute
rename_files_in_folder(folder_id = "your_folder_id", dry_run = TRUE)
