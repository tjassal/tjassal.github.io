---
title: 'New paper establishes a framework to map forest functional type in the forest-shrubland ecotone using predictive habitat distribution modeling'
author: 'Tim Assal'
date: 2015-08-25 00:00:00
description: forest ecotone, lay summary, logistic regression model, phenology, science communication, spatial scale, species distribution modeling, SPOT5
featured_image: '/images/blog/pine_mtn_pano1.jpg'
---

<figure>
  <img src='../../images/blog/2012-LM-a.jpg' style="width: 50%; height= 50%">
  <figcaption>Early autumn on Little Mountain, Wyoming .</figcaption>
</figure>

We recently published a paper in the journal Remote Sensing Letters, on mapping forest functional type in a forest-shrubland ecotone. Our study area is located in the southern portion of the Wyoming Basin Ecoregion centered on several prominent forested ridges surrounded by shrubland. Although the forests are extensive in some areas, they are characterized by small, isolated patches that act as islands in a sea of sagebrush. The forest-shrubland ecotone (or transition area) provides habitat for many different species and therefore it is important to have accurate data on the type, size and extent of forest type.

However, in heterogeneous ecosystems such as the one, regional and national land cover mapping products typically lack the spatial resolution needed to adequately characterize the extent and juxtaposition of land cover. We present a framework that incorporates aerial photos, satellite imagery and topographic information to model dominant forest cover at local scales across a forest-shrubland ecotone.

<figure>
  <img src='../../images/blog/DP_pano2.jpg' style="width: 50%; height= 50%">
  <figcaption>Canyon country below the forested bluffs on Diamond Peak, Colorado.</figcaption>
</figure>

<figure>
  <img src='../../images/blog/2010-LM-154b.jpg' style="width: 50%; height= 50%">
  <figcaption>A small patch of forest on Little Mountain, Wyoming.</figcaption>
</figure>

<figure>
  <img src='../../images/blog/DSCN8560.jpg' style="width: 50%; height= 50%">
  <figcaption>Mortality in the forest-shrubland ecotone on Middle Mountain, Colorado.</figcaption>
</figure>


The driving concept of the analysis was to exploit phenological differences in forest cover type by “viewing” the forest at different times of the year. Phenology is the study of the timing of specific biological events, such as plant flowering, animal migration, reproduction, etc. The phenological event of interest in our study is leaf drop by deciduous trees in autumn. Simply put, deciduous forests look different to our eyes (and satellites) in the summer than they do once the leaves turn color and fall off in autumn. Deciduous forest and coniferous forest look slightly different during the summer, but they look very different after deciduous leaves fall to the ground. In our study area, the iconic Quaking aspen tree is the sole deciduous forest type. Satellites can differentiate between vegetation types based on the amount of radiation that is absorbed or reflected which is different when there are leaves on the trees compared to when the leaves are off the trees. In our study we interpreted forest cover type in aerial photos and used this to “scale-up” the information to satellite imagery. We developed probability of occurrence models for both deciduous and coniferous forest, and then combined the model outputs into a synthesis map depicting forest cover type.

<figure>
  <img src='../../images/blog/lme_woodland2.jpg' style="width: 50%; height= 50%">
  <figcaption>Extensive forest on Little Mountain, Wyoming.</figcaption>
</figure>

The output of this project provides valuable information that we used in subsequent research to assess the effects of drought on forest community type in this semi-arid region [(Assal et al. 2016)](https://www.sciencedirect.com/science/article/pii/S0378112716000189). The results from our analysis are suitable to characterize the extent and juxtaposition of forest cover in a highly heterogeneous ecosystem (see below). The input data we used in the models has a resolution of 10 meters and the output synthesis map has an overall classification accuracy of 87%. This approach enabled us to capture the extent and pattern of broad forest and very small and isolated patches that are missed by regional land cover data. Furthermore our framework utilizes open access aerial photos (source: National Agriculture Imagery Program) and satellite data (source: SPOT5 – North America Data Buy). In this way, it is transferable to other highly heterogeneous ecosystems to develop critical baseline tree cover data that can be updated at regular intervals to monitor the effects of disturbance and long-term ecosystem dynamics. Finally, our analysis addressed spatial autocorrelation in species distribution models (SDMs). Spatial autocorrelation is often ignored in SDMs and there is not a lot of literature on how to test for it in logistic regression models. It is my hope that this paper provides information on both aspects of spatial autocorrelation.

<figure>
  <img src='../../images/blog/Figure3.jpg' style="width: 50%; height= 50%">
  <figcaption>Comparison of forest type maps derived from each data source of a representative area of
the landscape on Little Mountain: (a) 2009 colour-infrared aerial photo (National Agriculture
Imagery Program) where dark red/black hues indicate coniferous forest, red hues indicate deciduous forest, grey/light red/blue hues represent non-forest and (b) USGS synthesis map.
Note: Each map panel is displayed at the same scale and extent.</figcaption>
</figure>

<figure>
  <img src='../../images/blog/DSCN8514.jpg' style="width: 50%; height= 50%">
  <figcaption>Aspen stand on Cold Spring Mountain, Colorado.</figcaption>
</figure>

<figure>
  <img src='../../images/blog/DSCN8565.jpg' style="width: 50%; height= 50%">
  <figcaption>Forest-shrubland ecotone at the Wyoming-Colorado stateline.</figcaption>
</figure>

Literature Cited: 
**Literature Cited**
+ Assal, T.J., Anderson, P.J., Sibold, J., 2016. [Spatial and Temporal Trends of Drought Effects in a Heterogeneous Semi-Arid Forest Ecosystem](https://www.sciencedirect.com/science/article/pii/S0378112716000189). Forest Ecology and Management. 365, 137-151.  
+ Assal, T.J., Anderson, P., Sibold, J., 2015. [Mapping forest functional type in a forest-shrubland ecotone using SPOT imagery and predictive habitat distribution modelling](https://www.tandfonline.com/doi/full/10.1080/2150704X.2015.1072289). Remote Sensing Letters. 6, 755–764.  

***Top image: Looking southwest at Middle Mountain and Diamond Peak, Colorado from Pine Mountain, Wyoming.***
