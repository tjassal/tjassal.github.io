---
title: 'Test - R Markdown script'
author: 'Tim Assal'
date: 2022-03-31 00:00:00
description: forest disturbance, burn severity, tree regeneration, Araucaria-Nothofagus, science communication
featured_image: '/images/blog/tnp14.jpg'
---


```{r setup, include=FALSE, cache=FALSE} 
knitr::opts_chunk$set(echo = TRUE) 
knitr::opts_chunk$set(error = TRUE) #this will allow it to knit with errors for demonstration purposes and cache=F
```

<style type="text/css">

body{ /* Normal  */
      font-size: 12 px;
}
</style>

## Week 11 Lesson: Spatial Data Visualization and Manipulation
#### Tim Assal
**Some of the material for this lesson was adapted from Data Carpentry Introduction to Geospatial Concepts. Thanks to Leah Wasser; Megan A. Jones; Lauren O'Brien; Joseph Stachelek; Tom Wright; Tracy Teal; Dev Paudel; Jane Wyngaard; Anne Fouilloux; Bidhyananda Yadav; Chris Prener; Tyson Swetnam; Erin Becker; Katrin Leinweber

We will go through this lesson in class, but I would like each of you to type the code as we go to get used to executing code in RStudio.  

### This lesson will cover:

1. Map Your Data
2. Create Data
3. Manipulate Data
4. Map Packages in R


##### In the last lesson, we downloaded the Ohio Data and worked through projections so that all data was in the same projection. We will pick up today with the same data. If you haven't worked through Section 5 and 6 from the last lesson, please go back and do so now. If you already have, you will be able to open up the same Rproject and begin here. 

**Reminder: if you haven't downloaded the data yet**
I've posted the data for this portion of lesson on my [course github page](https://github.com/tjassal/DataAnalysisR_Course). Click on the Ohio_Data.zip, then on the next screen, click the download button (right side of screen). Unzip the file and place all of the data inside your working directory in a directory named "SourceData". At this time also create a "DerivedData" directory. Then you can create a new R project and load the data later in the lesson as needed. 

### 1. Map Your Data

I pulled this from my GIS Day demo. 

First load the following libraries (remember you might need to install some of them):
```{r, message=FALSE, warning=FALSE}
library(raster)
library(ggplot2)
library(sf)
library(gridExtra)
```

#### Map 1 - KSU Campus Buildings

First we will load the required shapefiles:

```{r, message=FALSE}
KSU_Campus <- st_read("SourceData/KSU_Boundary.shp")
KSU_Buildings <- st_read("SourceData/KSU_Buildings.shp")
```

Next we will make the map using ggplot:

```{r, message=FALSE}
Map1<-ggplot() +
  #load campus boundary first
  geom_sf(data = KSU_Campus, size = 0.25, color = "black", fill = "gray80") + 
  #load buildings second - ggplot adds each layer in order, so we want buildings on top
  geom_sf(data = KSU_Buildings, size = 0.5, color = "darkblue", fill = "yellow") +
  coord_sf()+
  #add labels
  labs(title = "Kent State University Campus",
       subtitle = "Building Footprints - 2019", 
       caption = "Data Sources: KSU Data (Map It!); OH Data (Ohio DOT)")+
  theme_linedraw() #this will remove the default gray background from the map
Map1 #plot map
```

We can save it to the Figures directory using ``ggsave()``:

```{r, message=FALSE}
ggsave("Figures/KSU_Map.jpg", Map1, width=8, height=4, dpi=300) #save map
```

#### Map 1b - Add a legend to the map using the `ggsn` package
```{r, message=FALSE}
#add legend to the same map
library(ggsn) #be sure to install the package first
Map1.legend<-ggplot() +
  #load campus boundary first
  geom_sf(data = KSU_Campus, size = 0.25, color = "black", fill = "gray80") + 
  #load buildings second - ggplot adds each layer in order, so we want buildings on top
  geom_sf(data = KSU_Buildings, size = 0.5, color = "darkblue", fill = "yellow") +
  coord_sf()+
  #add labels
  labs(title = "Kent State University Campus",
       subtitle = "Building Footprints - 2019", 
       caption = "Data Sources: KSU Data (Map It!); OH Data (Ohio DOT)")+
  theme_linedraw() +#this will remove the default gray background from the map
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank())+
  #add code for the scale bar
  scalebar(KSU_Campus, dist = 500, dist_unit = "m", 
           transform = FALSE, model = "WGS84", st.size = 3.5) 
Map1.legend #plot map
```
**Note: when you add code for the scale bar, it labels the axes x and y. To remove that, we add the two lines of code above the scalebar function.**

#### Map 2 - Kent Vicinity Map

Let's create a second map so we know where in Ohio Kent is located. 

First we'll load some additional shapefiles:
```{r, message=FALSE}
OH_County <- st_read("SourceData/OH_Counties.shp")
OH_Kent <- st_read("SourceData/Kent_OH_Boundary.shp")
```

Next we will make the map using ggplot:

```{r, message=FALSE}
Map2<-ggplot() +
  #load county boundaries first
  geom_sf(data = OH_County, size = 0.25, color = "black", fill = "gray80") + 
  #load Kent boundary second - ggplot adds each layer in order
  geom_sf(data = OH_Kent, size = 0.25, color = "black", fill = "red") +
  #here is a different way to add a title
  ggtitle("Location Map") + 
  #let's hide the axis ticks and labels since we aren't worried about those details at this scale
  theme(axis.ticks = element_blank(), axis.text.x = element_blank(), axis.text.y=element_blank())+
  theme_linedraw() #this will remove the default gray background from the map
Map2
```

Not bad, but if we show the town of Kent as a polygon it probably won't scale well. Let's convert the Kent polygon to a centroid, then we'll show it on the map as a point.

```{r, message=FALSE, warning=FALSE}
OH_Kent_Centroid <- st_geometry(st_centroid(OH_Kent))
```

Now we're ready to make another map using the new centroid:


```{r, message=FALSE}
inset.map<-ggplot() +
  #load county boundaries first
  geom_sf(data = OH_County, size = 0.25, color = "black", fill = "gray80") + 
  #load Kent centroid; we'll display as a square (shape = 15)
  geom_sf(data = OH_Kent_Centroid, size = 1, color = "red", shape= 15) +
  ggtitle("Kent Location Map") + 
  theme(axis.ticks = element_blank(), axis.text.x = element_blank(), 
        axis.text.y=element_blank(),
        panel.border = element_rect(colour = "black", fill=NA, size=1))+
  theme_linedraw() #this will remove the default gray background from the map
inset.map
```

This should be much better for scaling the map in the next step. 


#### Map 3 - Composite Map

Now let's put the two maps together into a composite map. Since we already wrote the two maps to objects, we can simply call them here and arrange using the ``gridExtra`` package. 


```{r, message=FALSE}
# We'll have two columns, specify the order and the width of each map
composite_map<-grid.arrange(Map1.legend, inset.map, ncol=2, widths=c(7,3))
composite_map
#save the map
ggsave("Figures/Composite_map.jpg", composite_map, width=8, dpi=300)
```

Now that's a publication quality map that didn't take all that much code to create. Hopefully you can use this template to create future maps. Go forth and be spatial!


#### Map 4 - Plot Vector and Raster Data on the same map

Now let's plot raster and vector data on the same map. 

If the raster data is not already loaded and reprojected from before, do so now:
```{r, message=FALSE}
#load data
Kent.Elev <- raster ("SourceData/kent_elev.tif")
st_crs(Kent.Elev)
#reproject
Kent.Elev.R<- projectRaster(Kent.Elev, crs = crs(KSU_Campus))
st_crs(Kent.Elev.R)
```

First, we need to prep the raster data for ggplot by converting it into a dataframe:
```{r, message=FALSE}
#convert raster cells to points
map.p<-rasterToPoints(Kent.Elev.R)
#convert the points to a dataframe
df <- data.frame(map.p)
#Rename column headings
colnames(df) <- c("Longitude", "Latitude", "Elev_m")
#Recall that this data set is in meters; let's create a new column of elevation in feet
df$Elev_ft<-df$Elev_m*3.28
```

Now we're ready to plot. Once we develop the raster plot, we can add a vector spatial object the same way we've already plotted them:
```{r, message=FALSE}
Map4<-ggplot() +
  geom_raster(data = df, aes(x = Longitude, y = Latitude, fill=Elev_ft)) + 
  scale_fill_gradientn(name = "KSU Campus Elevation", colors = terrain.colors(20)) +
  geom_sf(data = KSU_Campus, color = "blue", fill = NA) +
  coord_sf()+
  theme_linedraw() #this will remove the default gray background from the map
Map4
```


#### **Note: ``ggplot`` will allow you to plot vector spatial objects of two different projections on the same map. However, you will have problems if you attempt to plot vector and raster with different projections. It is good practice to ensure all of your data is in the same projection in R!**


### 2. Create Data

You will likely create more complex types of data using a GIS (e.g. polylines, polygons, raster, etc.). However, one basic exception is if you need to create points from a csv. 

Spatial data are sometimes stored in a text file format (`.txt` or `.csv`). If the text file has an associated `x` and `y` location column, then we can convert it into an `sf` spatial object. The `sf` object allows us to store both the `x,y` values that represent the coordinate location of each point and the associated attribute data - or columns describing each feature in the spatial object.

##### Import the .csv

First, we'll import the csv, the standard way using the tidyverse:
```{r, message=FALSE, warning=FALSE}
library(tidyverse)
KSU_POIs<-read_csv("SourceData/ksu_points_of_interest.csv")
```

Have a look at the data. It contains 10 points with an ID, a comment, and X and Y coordinates. *Note: I created some arbitrary points on campus with fabricated comments for this exercise*
It is important to identify the columns that contain the coordinate data. Here it is pretty obvious. Sometimes that attributes might be named "easting" and "northing" or even X1 and X2. 

It is ideal if the data has some type of metadata that identifies the projection information or even if your friend who gave you it tells you the projection that the data were collected in. Here we don't know. However, we know the data is in lat long decimal degrees, so we are going to assign it to the most common modern day ``CRS``: WGS84 (EPSG: 4326).

A particular CRS can be referenced by its EPSG code (i.e., epsg:4121). The EPSG is a structured dataset of CRS and Coordinate Transformations. It was originally compiled by the, now defunct, European Petroleum Survey Group. Here are some websites: http://www.epsg-registry.org/ http://spatialreference.org/ (although these are kind of confusing).


**See the ``Overview of CRS`` document posted on Blackboard for more info**

##### Convert the .csv to a spatial object

Now let's promote the csv to a spatial object. We will need to specify the attributes that contain the coordinates and assign the CRS:
```{r, message=FALSE}
KSU_POIs.sp<-st_as_sf(KSU_POIs, coords = c("X", "Y"), crs=4326)
```

We could also get the proj4string from the CRS and input that directly:

```{r, message=FALSE}
st_crs(4326)
KSU_POIs.sp<-st_as_sf(KSU_POIs, coords = c("X", "Y"), crs="+proj=longlat +datum=WGS84 +no_defs")
```

Now the points have a spatial component and can be added to a map!

#### Export spatial object as a .shp

We can export a spatial object to a shapefile:
```{r, message=FALSE}
st_write(KSU_POIs.sp, "DerivedData/KSU_POIs.shp", driver = "ESRI Shapefile")
```

Take note of the message above. If the data set already exists, you will need to add the append argument to tell R what to do. 

### 3. Manipulate Data

You might have the need to manipulate spatial data. This can be easier to do in a GIS, but if it's something you might want to do in R for a number of reasons. 

#### Create a Attribute

Suppose we want to create a new field, named "Person" that identifies the person that collected the data:
```{r, message=FALSE}
KSU_POIs.sp$Person<-"Tim"
```

Suppose we want to create a new identifier named "IDENT" in the ``KSU_POIs_SP``. The IDENT will contain the letter A-# (e.g. "A-1"):
```{r, message=FALSE}
KSU_POIs.sp$IDENT<-paste("A", sep="-", 1:nrow(KSU_POIs.sp))
```

#### Subset Vector Data

Suppose we want to subset the Ohio counties by ``name`` for the greater Kent, Akron, Clevland area and plot the data:
```{r, message=FALSE}
OH_County_NEOHIO <- OH_County %>% 
  filter(COUNTY == "PORTAGE"| COUNTY == "SUMMIT"| COUNTY == "CUYAHOGA"
         | COUNTY == "LAKE"| COUNTY=="GEAUGA")
#plot it
ggplot() +
  geom_sf(data = OH_County_NEOHIO, aes(fill=COUNTY)) +
  theme_linedraw() #this will remove the default gray background from the map
```

Suppose we want to subset the Ohio counties by two attributes. In this case we want to select counties > 1000 feet in elevation AND counties with a population > 200,000:
```{r, message=FALSE}
#subset by counties greater than 1000 feet in elevation and with Pop > 200,000
OH_County_HighElev_HighPop <- OH_County %>% 
  filter(ELEVATION_>1000 & POP_2010>200000)
#plot it
ggplot() +
  #add all counties for perspective
  geom_sf(data = OH_County, size = 0.25, color = "black", fill = "gray80") +
  geom_sf(data = OH_County_HighElev_HighPop, aes(fill=COUNTY)) 
```

**Notice anything about the logic used to subset these spatial objects? YES - it is the same as the logic we used to manipulate dataframes in Lesson 4 with the ``tidyverse``**

#### Spatial Joins

Joining two non-spatial datasets relies on a shared ‘key’ variable, as discussed in Lesson 4.  Spatial data joining applies the same concept, but instead relies on shared areas of geographic space (it is also know as spatial overlay). As with attribute data, joining adds a new column to the target object (the argument x in joining functions), from a source object (y). 

Suppose we want to add the county to the file that contains our KSU Points of Interest. First we need to ensure both files are in the same projection. **If we did not do this, the operation will fail.** We'll reproject OH_County into the KSU_POIs_SP projection:
```{r, message=FALSE}
#first we need to reproject OH_County
OH_County.P <- st_transform(OH_County, crs(KSU_POIs.sp)) 
#check the projections
st_crs(OH_County.P)
st_crs(KSU_POIs.sp)
#Cool, they match!
```


Next well perform a spatial join where we join the counties with the KSU points of interest. Notice, we need to specify the field we want returned, in this case COUNTY (for county name):
```{r, message=FALSE}
KSU_POI_County <- st_join(KSU_POIs.sp, left = FALSE, OH_County.P["COUNTY"]) # join points
#ignore the warning
head(KSU_POI_County)
```

You can see the new attribute "County" and it lists the county that each point is located in. Keep in mind, this dataset only has 10 points, all located on campus, so every point will have Portage County. However, if your point dataset had thousands of points located throughout the state or country, this same bit of code will provide the spatial join needed to link the point to the respective county. 


#### Aggregate Data

At times you might want to combine multiple features into one; a process called `Union``.  For example, let's say you want to create a study area consisting of Portage, Summit and Stark counties. First we would subset those counties by ``name``:

```{r, message=FALSE}
OH_County_StudyArea<- OH_County %>% 
  filter(COUNTY == "PORTAGE"| COUNTY == "SUMMIT"| COUNTY == "STARK")
#plot it
ggplot() +
  geom_sf(data = OH_County_StudyArea, aes(fill=COUNTY)) +
  theme_linedraw() #this will remove the default gray background from the map
```

Next we want to union the counties so our study area is only one polygon:

```{r, message=FALSE}
Study.Area.union<-st_union(OH_County_StudyArea)

#plot it
ggplot() +
    geom_sf(data = Study.Area.union, color="blue") +
  theme_linedraw() #this will remove the default gray background from the map
```

Notice, they is only one polygon now. 

Next we might want to buffer our study area, a common geospatial process. 

First, we will reproject the data to meaningful units: 
```{r, message=FALSE}
#reproject to UTM Z17 north
Study.Area.union.P<-st_transform(Study.Area.union, crs("+proj=utm +zone=17 +datum=WGS84 +units=m +no_defs"))
st_crs(Study.Area.union.P)
```

The units of UTM are meters; it is much easier to visualize how large a meter is compared to a degree. 

Next, let's buffer the study area by 5 km or 5,000 m:
```{r, message=FALSE}
#now buffer
Study.Area.Buffer.5km <- st_buffer( Study.Area.union.P, 5000)

#plot it
ggplot() +
  geom_sf(data = Study.Area.union, color="blue") +
  geom_sf(data = Study.Area.Buffer.5km, color="red", fill=NA) +
  theme_linedraw() 
```

#### Area Calculations

How large is the study area vs. the buffered study area?
```{r, message=FALSE}
st_area(Study.Area.union.P)
st_area(Study.Area.Buffer.5km)
```


How much additional area was added to the study area with the 5 km buffer?
```{r, message=FALSE}
area.difference<-st_area(Study.Area.Buffer.5km)-st_area(Study.Area.union.P)
area.difference
```

### 4. Map Packages in R

There are a lot of different map packages in R to create a map using base data. See the vignettes (google it) associated with each package for more details. You might check out the 
`maps`, `tmap` or `leaflet` packages. However, one good option to make a basic map is to use the `spData` package in tandem with the `sf` package.

For example, lets subset a three-state study area, then plot on top of a map of the USA. 

```{r, message=FALSE}
library(spData)
library(sf)

#subset the base data us_states to only include three states
AOI.states<-us_states %>%
  filter(NAME=="Ohio"|NAME=="Indiana"|NAME=="Illinois") ##partition 3 states under scrutiny##

#now map it
Map1<-ggplot() +
  #Create map through ggplot##
  geom_sf(data = us_states, size = 0.25, color = "black", fill = "gray80") +
  geom_sf(data = AOI.states, size = 0.25, color = "black", fill = "red") +
  coord_sf()+
  # addinglabels, size, color specifics##
  theme_linedraw() #this will remove the default gray background from the map
Map1 #plot map
```

**This same process can be used to create a static map of a country. See the package help files or the google for more details.**

Below is an example of a dynamic map using `leaflet` which is an open-source JavaScript library that is used to create dynamic online maps. The identically named R package makes it possible to create these kinds of maps in R as well.

```{r, message=FALSE}
#load packages; be sure to install them first
library(leaflet)
library(mapview) #needed to export map

#let's create a simple map with a marker for McGilvrey Hall on campus
leaflet.map <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=-81.35073, lat=41.15052, popup="McGilvrey Hall - KSU Campus")
leaflet.map  # Print the map
```

**Note: this code uses the default Open StreetMap background and you can zoom in and out of the map in RStudio. Also, there will be a new button on the viewer window in RStudio to the right of the broom. Click it and it will open your dynamic map in a web browser!**

You can export the map using the `mapview` package
```{r, message=FALSE}
#export map
mapshot(leaflet.map, file = "Figures/KSU.png") #note the relative path
```
**Note, if you receive a message that PhantonJS is not found, simply install it using the line of code: "webshot::install_phantomjs()"**


#### More Advanced Maps with Leaflet
First we create our basemap with leaflet() and add different provider tiles and 
a layers control so that users can switch between the different basemaps.
```{r, message=FALSE}
basemap <- leaflet() %>%
  # add different provider tiles
  addProviderTiles(
    "OpenStreetMap",
    # give the layer a name
    group = "OpenStreetMap"
  ) %>%
  addProviderTiles(
    "Stamen.Toner",
    group = "Stamen.Toner"
  ) %>%
  addProviderTiles(
    "Stamen.Terrain",
    group = "Stamen.Terrain"
  ) %>%
  addProviderTiles(
    "Esri.WorldStreetMap",
    group = "Esri.WorldStreetMap"
  ) %>%
  addProviderTiles(
    "Wikimedia",
    group = "Wikimedia"
  ) %>%
  addProviderTiles(
    "CartoDB.Positron",
    group = "CartoDB.Positron"
  ) %>%
  addProviderTiles(
    "Esri.WorldImagery",
    group = "Esri.WorldImagery"
  ) %>%
  # add a layers control
  addLayersControl(
    baseGroups = c(
      "OpenStreetMap", "Stamen.Toner",
      "Stamen.Terrain", "Esri.WorldStreetMap",
      "Wikimedia", "CartoDB.Positron", "Esri.WorldImagery"
    ),
    # position it on the topleft
    position = "topleft"
  )

#make your own marker
icon.fa <- makeAwesomeIcon(
  icon = "flag", markerColor = "red",
  library = "fa",
  iconColor = "black"
)
```

Now let's call those basemaps and set it so they can be selected from the map:
```{r, message=FALSE}
leaflet.map2 <- basemap %>%
  addAwesomeMarkers(lng=-81.35073, lat=41.15052, popup="McGilvrey Hall - KSU Campus",
                    icon=icon.fa) %>% 
  addLegend(
    colors = "red",
    labels = "Place of Interest",
    title = "Legend",
    opacity = 1, 
    position = "bottomleft")
leaflet.map2  # Print the map

#export map
mapshot(leaflet.map2, file = "Figures/KSU2.png")
```

Now let's create a map with a specific background for export, in this case ESRI WorldImagery (note, we also add a legend):
```{r, message=FALSE}
leaflet.map3 <- leaflet() %>%
  addProviderTiles("Esri.WorldImagery",group = "Esri.WorldStreetMap") %>%  
  addAwesomeMarkers(lng=-81.35073, lat=41.15052, popup="McGilvrey Hall - KSU Campus",
                    icon=icon.fa) %>% 
  addLegend(
    colors = "red",
    labels = "Place of Interest",
    title = "Legend",
    opacity = 1, 
    position = "bottomleft")
leaflet.map3  # Print the map

#export map
mapshot(leaflet.map3, file = "Figures/KSU3.png")
```

Or we could create a quick map by adding a rectangle. Do so by specifying the lower left and upper right coordinate pairs. In this example, I'll create a map around one of my alma maters: Colorado State University
```{r, message=FALSE}
leaflet() %>% addTiles() %>%  
  addRectangles(
    lng1=-105.097169, lat1=40.566280,
    lng2=-105.075201, lat2=40.579035,
    fillColor = "transparent"
  )
```

**See https://rstudio.github.io/leaflet/ for more information. You can also do a lot of additional customizing using the Leaflet Map Widget (https://rstudio.github.io/leaflet/map_widget.html)**
