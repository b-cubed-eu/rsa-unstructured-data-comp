[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
![GitHub License](https://img.shields.io/github/license/b-cubed-eu/rsa-unstructured-data-comp)

# rsa-unstructured-data-comp
Occurrence data in GBIF have various limitations and biases, due in part to biases in survey effort. Therefore, analyses that use these data to estimate biodiversity status and trends can be misleading.

This analysis forms part of a study to establish the necessary conditions for ensuring the accuracy of estimates on biodiversity status and trends. It compares results obtained when analyses use unstructured cube data from GBIF, with those from analyses using data from structured monitoring programs, which are designed to minimise biases and errors and provide a largely accurate representation of biodiversity. 

The analysis focuses on birds in the Western Cape of South Africa. The structured data are from the Southern African Bird Atlas Programme 2 (SABAP2). The analysis is performed for the Western Cape and for the area of the Western Cape where the Hessequa Systematic Atlassing Subproject is undertaken (near Stillbaai). SABAP2 uses a pentad grid  - grid cells at a 5-minute<sup>2</sup> spatial resolution (~ 8.2 km<sup>2</sup> in southern Africa). The analysis is performed at pentad resolution, and at quarter-degree grid cell resolution (nine pentads fit into one quarter-degree grid cell (15 min<sup>2</sup>))

This analysis forms part of the work of task 4.5 of the [B-Cubed project](https://b-cubed.eu/).

## Workflow
The most recent datasets can be downloaded from [GBIF](https://www.gbif.org/) and [SABAP2](https://sabap2.birdmap.africa/). The exact datasets used in the analyses can be downloaded by following the links provided in `prepare_&_compare_data_Hessequa.Rmd` and `prepare_&_compare_data_WesternCape.Rmd` saved in  `R`. The downloaded data is saved in `data\raw`.

Running the scripts in these two Rmds (`prepare_&_compare_data_Hessequa.Rmd` and `prepare_&_compare_data_WesternCape.Rmd`) will prepare the data for analysis, save the prepared data in `data\interim`, and perform the analysis. 

## Installation instructions
This repository can be downloaded onto your computer as a zip file, which will contain all the required folders. The main folder contains the Rstudio project file for the analysis (`rsa-unstructured-data-comp.Rproj`). This file should be opened to run the analysis.

Several R packages need to be installed from R Cran or GitHub. Executing the script below will install the required packages

### Install packages from R Cran

```{r}
packages = c("tidyverse", "here"", "sf", "rgbif", "iNEXT", "ggpubr", "RColorBrewer", "corrplot", "devtools")
```

```{r}
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)
```
### Install packages from GitHub

```{r}
devtools::install_github("b-cubed-eu/b3gbi")
install.packages("gcube", repos = "https://b-cubed-eu.r-universe.dev")
```
