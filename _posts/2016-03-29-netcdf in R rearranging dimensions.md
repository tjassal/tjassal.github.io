---
title: 'NetCDF Data in R: rearranging the dimensions for raster analysis'
author: 'Tim Assal'
date: 2017-04-17 00:00:00
description: array, Climate Data, Fuel Moisture Data, Gridded Surface Meteorological Data, netCDFNetwork Common Data Form, Open Science, R statistics, time series 
featured_image: '/images/blog/modis_header2.jpg'
---

I recently ran into some challenges working with netCDF data in R. Specifically, I wanted to extract data from a netCDF file and convert the file to a raster for additional analyses. It is pretty straightforward to import each time slice of a variable into a RasterBrick. However, once I tried this I realized the columns, rows, and layers from the netCDF file were not being read properly in R, resulting in an incorrect raster layer. The solution is to import the netCDF file into R as an array and then reorganize the array into the proper dimensions. I hope this is helpful and please let me know if you know of a better solution.

In this example, I am working with dead fuel moisture data available from Dr. John Abatzoglou’s Applied Climate Science Lab [website](https://www.climatologylab.org/gridmet.html).

```js
####Import the netCDF file
library(ncdf)
nc <- open.ncdf("fm100_2003.nc");
print(nc)
[1] "file fm100_2003.nc has 3 dimensions:"
[1] "lon   Size: 1386"
[1] "lat   Size: 585"
[1] "day   Size: 365"
[1] "------------------------"
[1] "file fm100_2003.nc has 1 variables:"
[1] "short dead_fuel_moisture_100hr[day,lon,lat]  Longname:dead_fuel_moisture_100hr Missval:-9999"
```

The netCDF file has 3 dimensions and the size of the day dimension corresponds to daily dead fuel moisture of 100-hour fuels for one year (365 days).  I can import these into a RasterBrick for additional analyses:

```js
####Import netCDF into RasterBrick
r <- "fm100_2003.nc"
b <- brick(r,varname="dead_fuel_moisture_100hr")
```

However, the issue is that the columns and layers in the RasterBrick are switched, which results in an incorrect raster for each layer in the brick. The dimensions of the RasterBrick should read 585, 1386, 810810, 365 instead of the dimensions below:

```js
class       : RasterBrick 
dimensions  : 1386, 365, 505890, 585  (nrow, ncol, ncell, nlayers)
resolution  : 1, 0.04166667  (x, y)
extent      : 37619.5, 37984.5, -124.793, -67.043  (xmin, xmax, ymin, ymax)
coord. ref. : NA 
data source : fm100_2003.nc 
names       : X49.3960227966309, X49.3543561299642, X49.3126894632975, X49.2710227966309, X49.2293561299642, X49.1876894632975, X49.1460227966309, X49.1043561299642, X49.0626894632975, X49.0210227966309, X48.9793561299642, X48.9376894632975, X48.8960227966309, X48.8543561299642, X48.8126894632975, ... 
degrees_north: 25.0626894632975, 49.3960227966309 (min, max)
varname     : dead_fuel_moisture_100hr
```

The solution is to import the netCDF file into R as an array and then reorganize the array into the proper dimensions.

Import the netCDF  file as an array:
```js
dname <- "dead_fuel_moisture_100hr"
array1 <- get.var.ncdf(nc, dname) 
dim(array1)
[1]  365 1386  585
```

The dimensions of array1 are days, columns, rows which need to be rearranged:

```js
#rearrange dimensions of an array
array2<-aperm(array1, c(3, 2, 1))
dim(array2)
[1]  585 1386  365
```

Now the array is organized properly into rows, columns, days. At this point you can access the depth range or each time slice (days 1 through 365) as a matrix:

```js
#extract timeslice to matrix
#extract day 001 to a matrix
fm.day.001<-array2[,,1]
...
#extract day 365 to a matrix
fm.day.365<-array2[,,365]
```

If needed, the matrix can be converted to a raster:

```js
r2<-raster(nrow=585,ncol=1386,vals=fm.day.001, xmn=-124.7722, xmx=-67.06383,  ymn=25.06269, ymx=49.39602)
```

***Top image: MODIS imagery, Uinta Mountains, UT***
