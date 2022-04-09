## Compress Digital Elevation Model


GDAL has to be installed in order to run the commands. One way to do this is to install QGIS. 

#### move to file location
```
cd PathToFile
```

#### compress image mosaic

##### Elevation
###### dtm_cog_lzw
```
gdal_translate dtm.tif  dtm_cog_lzw.tif -of COG -co COMPRESS=LZW -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm_cog_lzw_predictor
```
gdal_translate dtm.tif  dtm_cog_lzw_predictor.tif -of COG -co COMPRESS=LZW  -co PREDICTOR=YES -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm_cog_deflate
```
gdal_translate dtm.tif  dtm_cog_deflate.tif -of COG -co COMPRESS=DEFLATE -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm_cog_deflate_predictor
```
gdal_translate dtm.tif  dtm_cog_deflate_predictor.tif -of COG -co COMPRESS=DEFLATE -co PREDICTOR=YES -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm_cog_deflate_predictor2
```
gdal_translate dtm.tif  dtm_cog_deflate_predictor2.tif -of COG -co COMPRESS=DEFLATE -co PREDICTOR=STANDARD -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm_cog_zstd
```
gdal_translate dtm.tif  dtm_cog_zstd.tif -of COG -co COMPRESS=ZSTD -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm_cog_lzma
```
gdal_translate dtm.tif  dtm_cog_lzma.tif -of COG -co COMPRESS=LZMA -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm_cog_lerc
```
gdal_translate dtm.tif  dtm_cog_lerc.tif -of COG -co COMPRESS=LERC -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm_cog_lerc-zstd
```
gdal_translate dtm.tif  dtm_cog_lerc-zstd.tif -of COG -co COMPRESS=LERC_ZSTD -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm_cog_lerc-zstd_maxerror-001
```
gdal_translate dtm.tif  dtm_cog_lerc-zstd_maxerror-001.tif -of COG -co COMPRESS=LERC_ZSTD -co MAX_Z_ERROR=0.01 -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm_cog_lerc-zstd_maxerror-0025
```
gdal_translate dtm.tif  dtm_cog_lerc-zstd_maxerror-0025.tif -of COG -co COMPRESS=LERC_ZSTD -co MAX_Z_ERROR=0.025 -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```

###### dtm_cog_lerc-deflate
```
gdal_translate dtm.tif  dtm_cog_lerc-deflate.tif -of COG -co COMPRESS=LERC_DEFLATE -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```


##### RGB-encoded
###### dtm-rgb_cog_lzma
```
gdal_translate dtm_rgb.tif  dtm-rgb_cog_lzma.tif -of COG -co COMPRESS=LZMA -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm-rgb_cog_webp-100
```
gdal_translate dtm_rgb.tif  dtm-rgb_cog_webp-100.tif -of COG -co COMPRESS=WEBP -co QUALITY=100 -a_nodata none -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### dtm-rgb_webp-100_887bit
```
gdal_translate dtm_rgb.tif  dtm-rgb_webp-100_887bit.tif -co TILED=YES -co COMPRESS=WEBP -co WEBP_LOSSLESS=True -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co COPY_SRC_OVERVIEWS=YES -co DISCARD_LSB=0,0,1 -a_nodata none
```
###### dtm-rgb_webp-100_886bit
```
gdal_translate dtm_rgb.tif  dtm-rgb_webp-100_886bit.tif -co TILED=YES -co COMPRESS=WEBP -co WEBP_LOSSLESS=True -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co COPY_SRC_OVERVIEWS=YES -co DISCARD_LSB=0,0,2 -a_nodata none
```
###### dtm-rgb_webp-100_885bit
```
gdal_translate dtm_rgb.tif  dtm-rgb_webp-100_885bit.tif -co TILED=YES -co COMPRESS=WEBP -co WEBP_LOSSLESS=True -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co COPY_SRC_OVERVIEWS=YES -co DISCARD_LSB=0,0,3 -a_nodata none
```

##### hillshade
###### gdal multidirectional hillshade jpeg
gdaldem hillshade dtm.tif md-hillshade_jpeg.tif -of GTiff -b 1 -z 1.0 -s 1.0 -alt 45.0 -multidirectional -co COMPRESS=JPEG -co JPEG_QUALITY=75