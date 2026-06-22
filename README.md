# Carbon Synthesis Working Group

## Purpose

Data synthesis project to create web-based tool for land use planning for carbon projects in the Sacramento-San Joaquin Delta

Principal Investigators: 

- Alyssa Burns
- Hannah Chaney
- Brooke Eastman
- Megan Pagliaro
- Melissa Palmisciano
- Tara Pozzi
- Diana Zapata

## Content

There are five main folders: data, sandbox, scripts, tools, and graphs.

*Data folder* is private and only visible by our team. We keep most of our data in a Box folder, where there are two data folders: raw for the original datasetes and clean for the wrangled datasets. Each subfolder under the raw, misc, or processed data will contain the name of the datasource. If the name is an acronym, then the description of the subfolder will contain the whole name.
-Raw: This folder contains all unprocessed data files. LSPT: This folder contains all files sourced from the Landscape Scenario Planning Tool.
-Processed: This folder contains data that has been cleaned.
-Misc: This folder contains miscellaneous data.

*Sandbox folder* contains extra scripts, tools, graphs, etc. that we made at some point, would like to keep, but not house within the main scripts, tools, and graphs folers. 

*Scripts folder* contains all of our scripts. Scripts have numerical padding according to order of operation. 

- "00_example_script.R": Example code to write at the start of each script to run the -setup.r and box_authentication.R scripts.
- "01_extract_crops_delta.qmd": Script to extract crop data for just the legal Delta region.

*Tools folder* contains any tools (e.g., helper scripts, setup code, etc) that may be needed to make our code run.

- "-setup.r": Code to setup file structure for local version of repo.
- "box_authentication.R": Code for pulling in data from Box

*Graphs folder* contains visual outputs from scripts. Outputs have numerical padding to signal which script they resulted from.

