# Example from CAGED: https://github.com/lter/lterwg-caged/blob/main/01_harmonize.R
## ------------------------------------------- ##
# File Name Information ----
## ------------------------------------------- ##

# Make sure all file names have correctly-formatted filenames
combo_v3 %>% 
  dplyr::select(source) %>% dplyr::distinct() %>% 
  dplyr::filter(stringr::str_count(string = source, pattern = "_") != 5)

# Break useful information out of file name ("source" column)
combo_v4 <- combo_v3 %>% 
  # Separate by underscore
  tidyr::separate_wider_delim(cols = source, delim = "_",
                              names = c("organization", "site", 
                                        "project.name", "sampling.years", 
                                        "excluded.group", "measured.group"),
                              cols_remove = F) %>%
  # Remove file name from final bit of file
  dplyr::mutate(measured.group = gsub(pattern = "\\.csv", replacement = "",
                                      x = measured.group)) %>% 
  # Relocate source back to first position
  dplyr::relocate(source, .before = dplyr::everything())

# Check structure
dplyr::glimpse(combo_v4)
