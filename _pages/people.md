---
title: People
#subtitle: Lab affiliates
description: Lab members and affiliates.
featured_image: /images/banners/Bariloche_pano_crop_sm.jpg
---

## Lab Members

##### Principal Investigator 

<img class="img-circle img-responsive img-center" src="/images/teampic/LM-rainbow.JPG" alt="" height="200" width="200" style="border-radius:50%">

<img class="img-circle img-responsive img-left" src="/images/teampic/LM-rainbow.JPG" alt="" height="200" width="200" style="float: left; margin-right: 1em;"> Can we add text here?  



Tim Assal, Ph.D.  
Assistant Professor  
Department of Geography  
McGilvrey Hall, Office 437   
email: tassal@kent.edu  
twitter: TimAssal  
github: tjassal  
cv: [PDF]  

{% include socials.html %}

{% include team_members.yml %}


##### Graduate Students 

* Mainul
* Michelle

##### Undergraduate Students 

* Hana

##### Research Staff 

* Nick 


## Staff
{% assign number_printed = 0 %}
{% for member in site.data.team_members %}

{% assign even_odd = number_printed | modulo: 2 %}

{% if even_odd == 0 %}
<div class="row">
{% endif %}

<div class="col-sm-6 clearfix">
  <img src="{{ site.url }}{{ site.baseurl }}/images/teampic/{{ member.photo }}" class="img-responsive" width="25%" style="float: left" />
  <h4>{{ member.name }}</h4>
  <i>{{ member.info }}<br>email: <{{ member.email }}></i>
  <ul style="overflow: hidden">

  {% if member.number_educ == 1 %}
  <li> {{ member.education1 }} </li>
  {% endif %}

  {% if member.number_educ == 2 %}
  <li> {{ member.education1 }} </li>
  <li> {{ member.education2 }} </li>
  {% endif %}

  {% if member.number_educ == 3 %}
  <li> {{ member.education1 }} </li>
  <li> {{ member.education2 }} </li>
  <li> {{ member.education3 }} </li>
  {% endif %}

  {% if member.number_educ == 4 %}
  <li> {{ member.education1 }} </li>
  <li> {{ member.education2 }} </li>
  <li> {{ member.education3 }} </li>
  <li> {{ member.education4 }} </li>
  {% endif %}

  {% if member.number_educ == 5 %}
  <li> {{ member.education1 }} </li>
  <li> {{ member.education2 }} </li>
  <li> {{ member.education3 }} </li>
  <li> {{ member.education4 }} </li>
  <li> {{ member.education5 }} </li>
  {% endif %}

  </ul>
</div>

{% assign number_printed = number_printed | plus: 1 %}

{% if even_odd == 1 %}
</div>
{% endif %}

{% endfor %}

{% assign even_odd = number_printed | modulo: 2 %}
{% if even_odd == 1 %}
</div>
{% endif %}







