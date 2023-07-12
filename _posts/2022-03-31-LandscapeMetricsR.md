---
title: 'Understanding Landscape Metrics in R: a crosswalk for Learning Landscape Ecology'
author: 'Tim Assal'
date: 2022-03-31 00:00:00
description:  R statistics, science outreach, open science, github
featured_image: '/images/blog/show_patches.png'
---

I'm teaching a Landscape Ecology course this semester and we're using Sarah Gergel and Monica Turner's [*Learning Landscape Ecology*](http://sarahgergel.net/lel/learning-landscape-ecology/) text for many of the labs. In Chapter 4, Understanding Landscape Metrics, parts 1 and 2 utilize hand calculations whereas parts 3 and 4 use Fragstats (McGarigal et al. 2012). I opted to use R, and the excellent [*landscapemetrics*](https://r-spatialecology.github.io/landscapemetrics/) package (Hesselbarth et al. 2019)  in lieu of Fragstats. 

There is a crosswalk R script needed to convert the original ascii files provided by the textbook into geoTIFFs. The geoTIFFs can be provided to students so they can simply call those files in their script. I've also created a student R script to get them started with parts 3 and 4 (note: I provide the students with an R primer early in the semester, but this course is not intended to teach them R). There is plenty for them to build on here, but if they follow the prompts and input code correctly, they can produce a helpful summary figure of faceted plots of the different metrics for the five landscapes and assess correlation between metrics: 

<figure>
  <img src='../../images/blog/Part4_landscape_metrics.jpg' style="width: 80%; height= 80%">
  <figcaption></figcaption>
</figure>

All of the materials are available on [github](https://github.com/tjassal/LandscapeEcology_Course/tree/main/ConvertLEECh4toR) if you’d like to use them. 

**References**

+ Gergel, S.E., and M.G. Turner (eds.). 2017. Learning Landscape Ecology: A practical guide to concepts and techniques, 2nd edition. Springer, New York. 482 pp. 978-1493963720
+ McGarigal, K., Cushman, S.A., and Ene E. 2012. FRAGSTATS v4: Spatial Pattern Analysis Program for Categorical and Continuous Maps. Computer software program produced by the authors at the University of Massachusetts, Amherst.
+ Hesselbarth, M.H.K., Sciaini, M., With, K.A., Wiegand, K., Nowosad, J. 2019. landscapemetrics: an open‐source R tool to calculate landscape metrics. Ecography, 42: 1648-1657 (ver. 0). 

***Top image: Grouped patches of the early settlement landscape in chapter 4 of Learning Landscape Ecology.***

