---
title: 'RasterViz in R: Drought Anomalies on California's Central Coast'
author: 'Tim Assal'
date: 2018-01-10 00:00:00
description: California drought, DataViz, NDVI time series, MODIS, science communication, RasterViz, R 
featured_image: '/images/blog/modis-central-ca.jpg'
---

Below is a brief example of raster visualization in R. It is a more thorough explanation of an example of rasterVIS that I will use in an upcoming lecture to the Anthropology and Geography group of the [Social Sciences Department](https://socialsciences.calpoly.edu/) at Cal Poly University. The goal is to gain a brief understanding on vegetation productivity dynamics in the vicinity of San Luis Obispo and the Central Coast using remote sensing and R. I've selected 17 HUC 10 watersheds from the [National Hydrography Dataset](https://nhd.usgs.gov/) as the area of interest.

We know when the drought hit at a statewide level from the [US Drought Monitor](http://droughtmonitor.unl.edu/). Now let's use satellite data and R to visualize the drought at a local scale using a reproducible example in R.

<figure>
  <img src='../../images/blog/UNL_CA_drought.jpg' style="width: 35%; height= 35%">
  <figcaption>Data from US Drought Monitoring Center indicates the Central Coast did not experience drought conditions in mid-August of 2006 (left); whereas it experienced exceptional drought in mid-August of 2014 (right).</figcaption>
</figure>

I used [eMODIS](https://lta.cr.usgs.gov/emodis) (EROS Moderate Resolution Imaging Spectroradiometer) data to characterize the NDVI derived productivity of the AOI during the month of August. eMODIS is a standardized product which uses MODIS surface reflectance from a 7-day composite period (Brown et al. 2015). I used all eMODIS images from August during the period 2000 through 2016 to calculate the 17-year August mean. I then calculated August productivity anomalies for a dry year (2014) and an average year (2006) to identify the spatial and temporal variability in productivity within the watershed.

To execute the example below, please download the data [here](https://github.com/tjassal/tjassal.github.io/blob/gh-pages/uploads/SLO_Data.zip). I have not included the base data or code to calculate the global mean and annual anomalies.

Load the required packages in R (note: the Rcolorbrewer package is loaded with the [rasterVis](https://oscarperpinan.github.io/rastervis/) package).

```js
library(rgdal)   #Geospatial Data Abstraction Library
library(raster)  #Geographic data analysis & modeling Lib
library(rasterVis) #Raster Visualization libraryLoad the required data:

#load .shp (proj is the same as the raster data)
huc.shp <- readOGR(".", "SLO_HUC10_LEA")

#load raster data
Global.mean.August<-raster("August_GLOBAL_MEAN.tif")
August.2006.Z<-raster("August_2006_Z.tif")
August.2014.Z<-raster("August_2014_Z.tif")

#plot mean August NDVI 2000-2016
# set a color ramp of yellow to green
cols <- colorRampPalette(brewer.pal(9,"YlGn"))
# create a level plot - for Mean August NDVI
p<-levelplot(Global.mean.August,main="Average August Productivity (NDVI; 2000-2016)",
             col.regions=cols)
# overlay the spatialpolygonsdataframe
map.overlay<-p+layer(sp.lines(huc.shp, lwd=1, col='black'))
#plot the data
plot(map.overlay)

#export graphic
jpeg("Global_mean_August.jpg",width=8,height=8,units="in",res=1200)
plot(map.overlay)
dev.off() # turn off png device
```

<figure>
  <img src='../../images/blog/Global_mean_Aug-central-ca.jpg' style="width: 35%; height= 35%">
  <figcaption>Note: the NDVI values are scaled by a value of 10000. The gray graphics along the top and left axes represent the mean of the row (right) and column (top) values.</figcaption>
</figure>

```js
#plot Aug 2014 anomaly (dry year)
# set a color ramp of red to blue
cols <- colorRampPalette(brewer.pal(9,"RdBu"))
p<-levelplot(August.2014.Z,main="August 2014 NDVI Anomaly",
             col.regions=cols)
map.overlay<-p+layer(sp.lines(huc.shp, lwd=1, col='black'))
plot(map.overlay)

#export graphic
jpeg("Aug2014_Anomaly.jpg",width=8,height=8,units="in",res=1200)
plot(map.overlay)
dev.off() # turn off png device

#plot Aug 2006 anomaly (average year)
cols <- colorRampPalette(brewer.pal(9,"RdBu"))
p<-levelplot(August.2006.Z,main="August 2006 NDVI Anomaly",
             col.regions=cols)
map.overlay<-p+layer(sp.lines(huc.shp, lwd=1, col='black'))
plot(map.overlay)

#export graphic
jpeg("Aug2006_Anomaly.jpg",width=8,height=8,units="in",res=1200)
plot(map.overlay)
dev.off() # turn off png device
```

<figure>
  <img src='../../images/blog/Aug2014_Anom-central-ca.jpg' style="width: 35%; height= 35%">
</figure>

<figure>
  <img src='../../images/blog/Aug2006_Anom-central-ca.jpg.jpg' style="width: 35%; height= 35%">
  <figcaption>Compare drought-year anomalies (top) with average-year anomalies (bottom). The anomalies are analogous to Z-scores and were calculated as the deviation from mean, normalized by the standard deviation. These maps clearly indicate that the majority of the area experienced very strong negative anomalies (dark red) in 2014 and a mix of positive (blue) and subtle negative anomalies (light red) in 2006.</figcaption>
</figure>

***Top image: MODIS image of central California from [NASA Earth Observatory](https://earthobservatory.nasa.gov/IOTD/view.php?id=91379).***

