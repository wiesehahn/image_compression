
# GeoTiff Image Compression

## Orthophoto

### Original data

Original data were RGB-Orthoimages which were present as 93 uncompressed image tiles together with corresponding overviews. 

The tiles had following properties:
    - Bands:        3
    - Width:	    15000
    - Height:	    15000
    - Data type:    Byte - Eight bit unsigned integer

#### Preprocessing

For further processing the tiles were mosaiced into one virtual raster (vrt) with the dimensions 165.000 x 180.000 pixel.

`gdalbuildvrt mosaic.vrt tiles\*.tif`


### Compression

The images were merged in mosaics (via the virtual raster file) and stored as single files with different compression types. An overview of the results can be seen below.

#### With Overviews

For a smooth visualization experience it is necessary to have overviews of the image at different zoom levels. Cloud optimized GeoTIFFs (COG) include them by default. 

| format                    	| compression 	| lossless 	| size (GB) 	| size (%) 	| comment                               	|
|---------------------------	|-------------	|----------	|-----------	|----------	|---------------------------------------	|
| GeoTIFF-tiles + overviews 	| none        	| yes      	| 72        	| 100      	| original                              	|
| COG                       	| LZW         	| yes      	| 68        	| 94       	| fast to write slow to read            	|
| COG                       	| DEFLATE     	| yes      	| 55        	| 76       	| fast to read                          	|
| COG                       	| DEFLATE     	| yes      	| 45        	| 63       	| Predictor=YES                         	|
| COG                       	| ZSTD        	| yes      	| 55        	| 76       	| higher compression speed than Deflate 	|
| COG                       	| LZMA        	| yes      	| 45        	| 63       	| very slow to write                    	|
| COG                       	| LERC        	| yes      	| 43        	| 60       	| MAX_Z_ERROR=0                         	|
| COG                       	| LERC_ZSTD   	| yes      	| 43        	| 60       	|                                       	|
| COG     	                    | WEBP (100%)   | yes      	| 34        	| 47       	| lossless WebP, very slow to write  	    |
| COG                       	| JPEG (75%)  	| no       	| 4         	| 6        	| YCbCr-Colorspace                      	|
| COG                       	| JPEG (75%)  	| no       	| 4         	| 6        	| YCbCr-Colorspace, NoData              	|
| COG                       	| WEBP (75%)  	| no       	| 3         	| 4        	|                                        	|

#### Without Overviews

If data should be stored just to archive it and for some analyzing workflows it might not be necessary to have overviews. To compare the size without overviews some regular mosaics were generated.

| format         	| compression 	| lossless 	| size (GB) 	| size (%) 	| comment          	|
|----------------	|-------------	|----------	|-----------	|----------	|------------------	|
| GeoTIFF-tiles  	| none        	| yes      	| 60        	| 100      	| original         	|
| GeoTIFF-mosaic 	| LZW         	| yes      	| 50        	| 83       	|                  	|
| GeoTIFF-mosaic 	| JPEG (75%)  	| no       	| 8         	| 13       	|                  	|
| GeoTIFF-mosaic 	| JPEG (75%)  	| no       	| 3         	| 5        	| YCbCr-Colorspace 	|



## Elevation

A completely different type of data is elevation data (e.g. digital terrain or canopy models). While it can also be stored as raster data its structure is completely different from photographic data such as above Ortho-imagery. Instead of three (or more) bands its data is located in a single band (just one value per location). But this single value can be much more differentiated (floating data instead of integer). For this reasons compression algorithms have a different performance on elevation data than they do for photographic data. 

### Original data

The image had following properties:
    - Bands:        1
    - Width:	    4000
    - Height:	    4000
    - Data type:    Float32 - Thirty two bit floating point


### Compression


#### One-band Elevation

| format  	| compression  	| lossless 	| size (MB) 	| size (%) 	| comment                                        	|
|---------	|--------------	|----------	|-----------	|----------	|------------------------------------------------	|
| GeoTIFF 	| none         	| yes      	| 65        	| 100      	| original                                       	|
| COG     	| LERC         	| yes      	| 83        	| 135      	| MAX_Z_ERROR=0                                  	|
| COG     	| LZW          	| yes      	| 61        	| 94       	| fast to write slow to read                     	|
| COG     	| DEFLATE      	| yes      	| 46        	| 71       	| fast to read                                   	|
| COG     	| LERC_DEFLATE 	| yes      	| 46        	| 71       	|                                                	|
| COG     	| ZSTD         	| yes      	| 44        	| 68       	| higher compression speed than Deflate          	|
| COG     	| LERC_ZSTD    	| yes      	| 44        	| 68       	|                                                	|
| COG     	| LZW          	| yes      	| 43        	| 66       	| Predictor=YES (predictor 3 for floating point) 	|
| COG     	| DEFLATE      	| yes      	| 35        	| 54       	| Predictor=YES (predictor 3 for floating point) 	|
| COG     	| DEFLATE      	| yes      	| 34        	| 53       	| Predictor=STANDARD (predictor 2 for integer)   	|
| COG     	| LZMA         	| yes      	| 27        	| 42       	| very slow to write                             	|
| COG     	| LERC_ZSTD    	| no       	| 12        	| 18       	| MAX_Z_ERROR=0.01 (precision of 1 cm)           	|
| COG     	| LERC_ZSTD    	| no       	| 8         	| 12       	| MAX_Z_ERROR=0.025 (precision of 2.5 cm)        	|
| COG     	| JPEG (75%)   	| no       	|           	|          	| only possible with 8-bit data                  	|
| COG     	| JPEG (75%)   	| no       	|           	|          	| only possible with 8-bit data                  	|
| COG     	| WEBP (75%)   	| no       	|           	|          	| only possible with 3 or 4 band data            	|

#### RGB-encoded

Another possibility to store the data is to encode the elevation in 3 channels. This has the advantage that the 3 bands can be of datatype byte (0-255) which reduces file size.
This technique is often used for web mapping, where loaded tiles should be as small as possible to reduce loading times. 
Mapbox, Maptiler etc. use it with a precision factor of 0.1 which means that elevation is stored to the decimeter (e.g. 15.3 m).

Here we encoded the elevation with higher precision using R as follows:
```
startingvalue <- 10000
precision <- 0.01
rfactor <- 256*256 * precision
gfactor <- 256 * precision

r <- floor((startingvalue +dtm)*(1/precision) / 256 / 256)
g <- floor((startingvalue +dtm - r*rfactor)*(1/precision) / 256) 
b <- floor((startingvalue +dtm - r*rfactor - g*gfactor)*(1/precision))

rgb_dem <- c(r,g,b)

writeRaster(rgb_dem, "dtm_rgb.tif"), datatype="INT1U", NAflag=NA)
```

It can be decoded with the formula `elevation = -10000 + ((R * 256 * 256 + G * 256 + B) * 0.01)`.
(e.g. in QGIS `-10000 + (("dtm_rgb@1" * 256 * 256 + "dtm_rgb@2" * 256 + "dtm_rgb@3") * 0.01)`)



| format  	| compression 	| lossless 	| size (MB) 	| size (%) 	| comment            	|
|---------	|-------------	|----------	|-----------	|----------	|--------------------	|
| GeoTIFF 	| none        	| yes      	| 65        	| 100      	| original           	|
| GeoTIFF 	| none        	| (no)     	| 31        	| 48       	| RGB encoded        	|
| COG     	| LZMA        	| (yes)    	| 17        	| 26       	| RGB encoded as COG 	|
| COG     	| WEBP        	| (yes)    	| 8         	| 12       	| RGB encoded as COG WEBP |
| GeoTIFF     	| WEBP        	| (yes)    	| 5         	| 8       	| RGB encoded as WEBP with 7bits for B-band |
| GeoTIFF     	| WEBP        	| (yes)    	| 4         	| 6       	| RGB encoded as WEBP with 6bits for B-band |
| GeoTIFF    	| WEBP        	| (yes)    	| 3         	| 5       	| RGB encoded as WEBP with 5bits for B-band |


#### Hillshade

If data is only used for visualization it might be enough to use a hillshade, this can dramatically reduc file size.

| format  	| compression 	| lossless 	| size (MB) 	| size (%) 	| comment            	|
|---------	|-------------	|----------	|-----------	|----------	|--------------------	|
| GeoTIFF 	| none        	| yes      	| 65        	| 100      	| original           	|
| GeoTIFF 	| JPEG        	| no     	| 2         	| 3       	| hillshade JPEG 75%   	|



## Literature

- http://blog.cleverelephant.ca/2015/02/geotiff-compression-for-dummies.html
- https://wheregroup.com/blog/der-weg-zum-optimalen-geotiff/
- https://kokoalberti.com/articles/geotiff-compression-optimization-guide/
- https://gist.github.com/kgjenkins/877ff0bf7aef20f87895a6e93d61fb43
- https://medium.com/@frederic.rodrigo/optimization-of-rgb-dem-tiles-for-dynamic-hill-shading-with-mapbox-gl-or-maplibre-gl-55bef8eb3d86