---
title: 'Visualizing the COVID19 shutdown from space: The Venetian Lagoon'
author: 'Tim Assal'
date: 2020-03-28 00:00:00
description: forest biogeography, Populus tremuloides, science communication 
featured_image: '/images/blog/venice1.jpg'
---

The coronavirus has gripped the world the last few weeks. Many things are uncertain, anxiety is running high and academia has transitioned to remote course offerings. We as a society owe a huge debt of gratitude to our first responders, healthcare workers, scientists, researchers, food producers, restaurateurs, grocery clerks ….. and all of those I forgot.

There have been a number of social media clips depicting the reduction in emissions due to the slowdown of the global economy using satellite data. Notably from NASA’s Earth Observatory:

<blockquote class="twitter-tweet tw-align-center"><p lang="en" dir="ltr">Nitrogen dioxide over <a href="https://twitter.com/hashtag/China?src=hash&amp;ref_src=twsrc%5Etfw">#China</a> has dropped with the coronavirus quarantine, Chinese New Year, and a related economic slowdown. <a href="https://t.co/URfLNy0GZJ">https://t.co/URfLNy0GZJ</a> <a href="https://twitter.com/hashtag/NASA?src=hash&amp;ref_src=twsrc%5Etfw">#NASA</a> <a href="https://twitter.com/hashtag/COVID2019?src=hash&amp;ref_src=twsrc%5Etfw">#COVID2019</a> <a href="https://t.co/PM60uL772K">pic.twitter.com/PM60uL772K</a></p>&mdash; NASA Earth (@NASAEarth) <a href="https://twitter.com/NASAEarth/status/1235330706827554817?ref_src=twsrc%5Etfw">March 4, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

Italy has been extremely hard hit during this pandemic and the entire country was put on lockdown on March 9th. [Cat Clifford](https://www.cnbc.com/2020/03/18/photos-water-in-venice-italys-canals-clear-amid-covid-19-lockdown.html) and [Denise Chow](https://www.nbcnews.com/science/environment/coronavirus-shutdowns-have-unintended-climate-benefits-n1161921) each wrote brief articles last week detailing the increased clarity in the Venetian canal’s due to the coronavirus slowdown.

<blockquote class="twitter-tweet tw-align-center"><p lang="en" dir="ltr">A ripple effect of the coronavirus lockdown provides a bit of reprieve for Venice. I imagine if that City were a woman, She&#39;s stretching her aching back, tired from the constant parade of tourist plodding. <a href="https://t.co/Xq6R9zp8YR">https://t.co/Xq6R9zp8YR</a></p>&mdash; Catherine Clifford (@CatClifford) <a href="https://twitter.com/CatClifford/status/1240324723382325248?ref_src=twsrc%5Etfw">March 18, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

I was pretty sure the Google Earth Engine archive would not have any imagery with the spatial detail to detect changes in the clarity of the canals (maybe the Grand Canal?). I decided to have a look though, as it would make a nice segue for my change detection lecture in my remote sensing course this week. The 10-m spatial resolution of [Sentinel-2 imagery](http://www.timassal.com/2016/06/30/sentinel-2a-satellite-bolsters-the-open-access-earth-observation-record/) is not adequate to detect changes in suspended sediment in any of the canals, but the lack of boat traffic around the island compared to this time last year is quite noticeable! Below are two false-color composite images – one from last March and one from last week – for visual comparison.

#### The Venetian Lagoon March 15, 2019:

<figure>
  <img src='../../images/blog/GEE_S2_15March2019.jpg'>
  <figcaption>The Venetian Lagoon March 15, 2019. False-color composite image from Sentinel-2 Bottom of Atmosphere reflectance; using the near-infrared, red and green bands (bands 8, 4, 3 respectively). Note the visible wakes from boat traffic around the island.</figcaption>
</figure>

#### The Venetian Lagoon March 16, 2020:

<figure>
  <img src='../../images/blog/GEE_S2_16March2020.jpg'>
  <figcaption>The Venetian Lagoon March 16, 2020. False-color composite image from Sentinel-2 Bottom of Atmosphere reflectance; using the near-infrared, red and green bands (bands 8, 4, 3 respectively). Note the reduction in boat wakes around the island.</figcaption>
</figure>

For more information on Google Earth Engine, see my previous posts [here](http://www.timassal.com/2019/02/11/exploring-vegetation-dynamics-using-google-earth-engine/) and [here](http://www.timassal.com/2018/01/09/a-brief-foray-into-google-earth-engine-calculate-ndvi-from-the-cloud/). See below for the code used in Google Earth Engine to generate the images:


``` js
//pull down specific granule, add layer and set display parameters
var s2a= ee.Image('COPERNICUS/S2_SR/20190315T101021_20190315T101043_T32TQR');
Map.addLayer(s2a, {bands: ['B8', 'B4', 'B3'], max: 4000}, 'S2_15March2019')

var s2b= ee.Image('COPERNICUS/S2_SR/20200316T100021_20200316T100023_T32TQR');
Map.addLayer(s2b, {bands: ['B8', 'B4', 'B3'], max: 4000}, 'S2_16March2020')

// Center map on Venice, Italy
Map.setCenter(12.33, 45.43, 13);
```
* ***Header image: The Grand Canal (left) and Piazza San Marco (right) viewed from San Giorgio Maggiore during busier times (circa 2007), Venice, Italy.***

### OLD

I recently contributed a chapter entitled *“Quaking Aspen: The Iconic and Dynamic Deciduous Tree of the Rocky Mountains”* to an AAG special volume . The goal of the essay was to describe aspen’s dynamic nature, challenges associated with stewardship, and current management-science efforts in the West to a broad audience. The open access volume, [Denver and the Rocky Mountain West](http://www.aag.org/cs/publications/special/the_rocky_mountain_west), is a compendium of short essays on topics of geographic interest about the region as opposed to traditional research articles. The book was published by the [American Association of Geographers](http://www.aag.org/) to commemorate the host region of the 2020 meeting. Unfortunately the conference was cancelled due to the global COVID-19 pandemic. Rumor has it the meeting might return to Denver in 2023.

<figure>
  <img src='../../images/blog/Aspen-paul.jpg'>
  <figcaption>Paul Rogers, Western Aspen Alliance and Utah State University, Dale Bartos, USFS (retired) and others discuss aspen regeneration during an “Aspen Days” workshop in 2013 sponsored by the Wyoming Game and Fish Department.</figcaption>
</figure>

*  Assal, T. J. 2020. [Quaking Aspen: The Iconic and Dynamic Deciduous Tree of the Rocky Mountains.](https://www.researchgate.net/publication/340846160_Quaking_Aspen_The_Iconic_and_Dynamic_Deciduous_Tree_of_the_Rocky_Mountains) Pages 20–28 in M. J. Keables, editor. The Rocky Mountain West: A Compendium of Geographic Perspectives. American Association of Geographers, Washington D.C.
