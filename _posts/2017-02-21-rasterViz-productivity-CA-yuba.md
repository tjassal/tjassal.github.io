---
title: 'Raster Visualization in R: Vegetation productivity in the Yuba River Watershed'
author: 'Tim Assal'
date: 2017-02-21 00:00:00
description: California drought, DataViz, NDVI time series, MODIS, science communication, RasterViz, R 
featured_image: '/images/blog/raster-banner-gradient.jpg'
---

Below is a brief example of raster visualization in R. It is a more thorough explanation of an example of rasterVIS that I used in a recent lecture I gave in the [Department of Geography and Environment](https://geog.sfsu.edu/) at San Francisco State University. The goal is to gain a brief understanding on vegetation productivity dynamics in the Yuba River Watershed (where the [SFSU Sierra Nevada Field Campus](http://www.sfsu.edu/~sierra/) is located) and quickly display the data using Oscar Perpiñán's excellent R package [rasterVis](https://oscarperpinan.github.io/rastervis/).

I used [eMODIS](https://lta.cr.usgs.gov/emodis) (EROS Moderate Resolution Imaging Spectroradiometer) data to characterize the NDVI derived productivity of the Yuba River Basin during the month of August. eMODIS is a standardized product which uses MODIS surface reflectance from a 7-day composite period (Brown et al. 2015). I used all eMODIS images from August during the period 2000 through 2016 to calculate the 17-year August mean. I then calculated August productivity anomalies for a dry year (2014) and an average year (2006) to identify the spatial and temporal variability in productivity within the watershed (based on regional data; Malone et al. 2016).

To execute the example below, please download the data [here](https://github.com/tjassal/tjassal.github.io/blob/gh-pages/uploads/Yuba_Data.zip). I have not included the base data or code to calculate the global mean and annual anomalies.

Load the required packages in R (note: the Rcolorbrewer package is loaded with the [rasterVis](https://oscarperpinan.github.io/rastervis/) package).

```js
library(rgdal)   #Geospatial Data Abstraction Library
library(raster)  #Geographic data analysis & modeling Lib
library(rasterVis) #Raster Visualization library

#Load the required data: .shp (proj is the same as the raster data)
huc.shp <- readOGR(".", "yuba_watershed_HUC08_LEA")

#load raster data
Global.mean.August<-raster("august_yuba_mean_2000_2016.tif")
August.2006.Z<-raster("August_2006_Z.tif")
August.2014.Z<-raster("August_2014_Z.tif")

#Plot the mean productivity for August (2000-2016)
# set a color ramp of yellow to green
cols <- colorRampPalette(brewer.pal(9,"YlGn"))

# create a level plot - for Mean August NDVI
p<-levelplot(Global.mean.August,main="Average August Productivity (NDVI; 2000-2016) - Yuba River Watershed",
             col.regions=cols)

# overlay the spatialpolygonsdataframe
map.overlay<-p+layer(sp.lines(huc.shp, lwd=2.5, col='black'))

#plot the data
plot(map.overlay)

#export graphic
jpeg("Global_mean_August.jpg",width=8,height=8,units="in",res=1200)
plot(map.overlay)
dev.off() # turn off png device
```

<figure>
  <img src='../../images/blog/Global_mean_August-yuba.jpg' style="width: 35%; height= 35%">
  <figcaption>Note: the NDVI values are scaled by a value of 10000. The gray graphics along the top and left axes represent the mean of the row (right) and column (top) values.</figcaption>
</figure>

Plot the 2014 and 2006 August productivity anomalies:#plot Aug 2014 anomaly (dry year)

```js
# set a color ramp of red to blue
cols <- colorRampPalette(brewer.pal(9,"RdBu"))
p<-levelplot(August.2014.Z,main="August 2014 NDVI Anomaly - Yuba River Watershed",
             col.regions=cols)
map.overlay<-p+layer(sp.lines(huc.shp, lwd=2.5, col='black'))

#plot Aug 2006 anomaly (average year)
cols <- colorRampPalette(brewer.pal(9,"RdBu"))
p<-levelplot(August.2006.Z,main="August 2006 NDVI Anomaly - Yuba River Watershed",
             col.regions=cols)
map.overlay<-p+layer(sp.lines(huc.shp, lwd=2.5, col='black'))
```

<figure>
  <img src='../../images/blog/Aug2014_Anomaly-yuba.jpg' style="width: 50%; height= 50%">
</figure>

<figure>
  <img src='../../images/blog/Aug2006_Anomaly-yuba.jpg' style="width: 50%; height= 50%">
  <figcaption>Compare drought-year anomalies (top) with average-year anomalies (bottom). The anomalies are analogous to Z-scores and were calculated as the deviation from mean, normalized by the standard deviation. These maps clearly indicate that the majority of the area experienced very strong negative anomalies (dark red) in 2014 and a mix of positive (blue) and subtle negative anomalies (light red) in 2006.</figcaption>
</figure>

Literature Cited

Brown, J. F., D. Howard, B. Wylie, A. Frieze, L. Ji, and C. Gacke. 2015. Application-ready expedited MODIS data for operational land surface monitoring of vegetation condition. Remote Sensing 7:16226–16240.

Malone, S. L., M. G. Tulbure, A. J. Pérez-luque, T. J. Assal, L. L. Bremer, D. P. Drucker, V. Hillis, S. Varela, and M. L. Goulden. 2016. Drought resistance across California ecosystems: evaluating changes in carbon dynamics using satellite imagery. Ecosphere 7:1–19.

