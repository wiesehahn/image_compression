## Compress Orthophoto mosaic


GDAL has to be installed in order to run the commands. One way to do this is to install QGIS. 

#### move to file location
```
cd PathToFile
```

#### create virtual raster mosaic
```
gdalbuildvrt mosaic.vrt *.tif
```
```
gdalbuildvrt -srcnodata "0 0 0" mosaic_nodata.vrt *.tif
```

#### compress image mosaic

###### mosaic_cog_lzw
```
gdal_translate mosaic.vrt  mosaic_cog_lzw.tif -of COG -co COMPRESS=LZW -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```

###### mosaic_cog_deflate
```
gdal_translate mosaic.vrt  mosaic_cog_deflate.tif -of COG -co COMPRESS=DEFLATE -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```

###### mosaic_cog_deflate_predictor
```
gdal_translate mosaic.vrt  mosaic_cog_deflate_predictor.tif -of COG -co COMPRESS=DEFLATE -co PREDICTOR=YES -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### mosaic_cog_zstd
```
gdal_translate mosaic.vrt  mosaic_cog_zstd.tif -of COG -co COMPRESS=ZSTD -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### mosaic_cog_lzma
```
gdal_translate mosaic.vrt  mosaic_cog_lzma.tif -of COG -co COMPRESS=LZMA -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### mosaic_cog_lerc
```
gdal_translate mosaic.vrt  mosaic_cog_lerc.tif -of COG -co COMPRESS=LERC -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### mosaic_cog_lerc-zstd
```
gdal_translate mosaic.vrt  mosaic_cog_lerc-zstd.tif -of COG -co COMPRESS=LERC_ZSTD -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### mosaic_cog_jpeg
```
gdal_translate mosaic.vrt  mosaic_cog_jpeg.tif -of COG -co COMPRESS=JPEG -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### mosaic_cog_jpeg_nodata
```
gdal_translate mosaic_nodata.vrt  mosaic_cog_jpeg_nodata.tif -of COG -co COMPRESS=JPEG -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### mosaic_cog_webp
```
gdal_translate mosaic_nodata.vrt  mosaic_cog_webp.tif -of COG -co COMPRESS=WEBP -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```
###### mosaic_cog_webp-lossless
```
gdal_translate mosaic.vrt  mosaic_cog_webp-lossless.tif -of COG -co COMPRESS=WEBP -co QUALITY=100 -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -a_srs EPSG:25832 -co OVERVIEWS=IGNORE_EXISTING
```

###### mosaic_lzw
```
gdal_translate  mosaic.vrt  mosaic_lzw.tif -co COMPRESS=LZW -co TILED=YES -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES
```
###### mosaic_jpeg
```
gdal_translate  mosaic.vrt  mosaic_jpeg.tif -co COMPRESS=JPEG -co TILED=YES -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES
```
###### mosaic_jpeg-ycbcr
```
gdal_translate  mosaic.vrt  mosaic_jpeg-ycbcr.tif -co COMPRESS=JPEG -co TILED=YES -co NUM_THREADS=ALL_CPUS -co BIGTIFF=YES -co PHOTOMETRIC=YCBCR
```
