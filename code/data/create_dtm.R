##___________________________________________________
##
## Script name: create_dtm.R
##
## Purpose of script:
## create the uncompressed digital terrain model from raw Lidar data
##
##
## Author: Jens Wiesehahn
## Copyright (c) Jens Wiesehahn, 2022
## Email: wiesehahn.jens@gmail.com
##
## Date Created: 2022-04-09
##
## Notes:
##
##
##___________________________________________________

## use renv for reproducability

## run `renv::init()` at project start inside the project directory to initialze 
## run `renv::snapshot()` to save the project-local library's state (in renv.lock)
## run `renv::history()` to view the git history of the lockfile
## run `renv::revert(commit = "abc123")` to revert the lockfile
## run `renv::restore()` to restore the project-local library's state (download and re-install packages) 

## In short: use renv::init() to initialize your project library, and use
## renv::snapshot() / renv::restore() to save and load the state of your library.

##___________________________________________________

## install and load required packages

## to install packages use: (better than install.packages())
# renv::install("packagename") 

renv::restore()
library(here)
library(lidR)
library(terra)
library(sf)

##___________________________________________________

## load functions into memory
# source("code/functions/some_script.R")

##___________________________________________________


# load catalog or create and save if not existent
file <- here("data/interim/lidr-catalog.RData")
if(!file.exists(file)){
  folder1 <- here("K:/aktiver_datenbestand/ni/lverm/las/stand_2021_0923/daten/3D_Punktwolke_Teil1")
  folder2 <- here("K:/aktiver_datenbestand/ni/lverm/las/stand_2021_0923/daten/3D_Punktwolke_Teil2")
  ctg = readLAScatalog(c(folder1, folder2))
  save(ctg, file = file)
} else {
  load(here("data/interim/lidr-catalog.RData"))
}

# set projection
projection(ctg) <- 25832


# get single tile extent
# To visualize tiles:   mapview::mapview(ctg@data)
bbox <- st_bbox(ctg@data[33542,])


# load lidar data
las = clip_roi(ctg, bbox)
las <- filter_poi(las, Classification != 7 & # noise
                    Classification != 15) # other points (mainly cars)

# create dtm
dtm <- rasterize_terrain(las, res=0.25)

# save to disk
writeRaster(dtm, here("data/interim", "dtm.tif"), gdal="COMPRESS=NONE")


# encode as RGB
startingvalue <- 10000
precision <- 0.01
rfactor <- 256*256 * precision
gfactor <- 256 * precision

r <- floor((startingvalue +dtm)*(1/precision) / 256 / 256)
g <- floor((startingvalue +dtm - r*rfactor)*(1/precision) / 256) 
b <- floor((startingvalue +dtm - r*rfactor - g*gfactor)*(1/precision))

rgb_dem <- c(r,g,b)

writeRaster(rgb_dem, here("data/interim/tests", "dtm_rgb.tif"), datatype="INT1U", NAflag=NA)

# to decode
# elevation = -10000 + ((R * 256 * 256 + G * 256 + B) * 0.01)
