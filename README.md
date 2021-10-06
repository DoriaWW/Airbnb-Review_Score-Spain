# To review or not to review? That's the question

__Does the number of reviews that your listing is getting on AirBnB affect the actual review score? Does this effect differ between big or small cities in Spain?__

<p align="center">
  <img src="https://s3.amazonaws.com/blog4.0/blog/wp-content/uploads/Feature-Image_The-Ultimate-Guide-to-Airbnb-Reviews@2x-scaled.png" width="70%" />
</p>

## Motivation

We all know the feeling of opening an e-mail that asks you to leave a review on a product that you just bought or a listing that you stayed the night at. But do more reviews lead to a higher review score? Furthermore, this effect is examined at cities in Spain that differ in sizes, such as Malaga compared to the capital Madrid. This code is written in order to find answers to these questions.

The reason for diving into this problem is because review scores are an important factor for customers when they decide which listing to stay at. Hosts want a good review score and some push their guests to leave a review. The issue that arises is that more reviews may not necessarily lead to a higher review rating. This study is conducted in order to show hosts if they should or should not push their guests to leave reviews by analyzing the relationship between review score and the number of reviews, while taking certain moderators into account.

The study focusses on seven different cities in Spain. To be able to examine the differences between small and big cities, there are three categories; Big, Medium or Small. The number of residents determine the category of the city:
- A Big city has **more than** 1000000 (one million) residents
- A Medium city has **more than** 500000 residents
- A Small city has **less than** 500000 residents


The cities:

_Big_: Barcelona and Madrid

_Medium_: Sevilla, Valencia and Malaga

_Small_: Menorca and Girona

## Method and results

<!--- First, introduce and motivate your chosen method, and explain how it contributes to solving the research question/business problem. -->
**Research methode**

The research methode that is used in this project is regression analysis.

_"Explain choice of research methode"_

**Moderators**

The relationship between the number of reviews and actual review score may be influenced by other variables, which are integrated in the model as moderators. In this study, three moderators are considered, for which dummy coding is used.
1) City size. Each of the seven cities in Spain falls in either one of three categories; Big, Medium or Small, depending on the number of residents as was mentioned before. The base level of this variable is the "big" size. 
2) Room type. There are four categories in the dataset; Entire home/appartment, Hotel room, Private room or Shared room. In the dummy encoding, shared room is the base level. 
3) Superhost status. The dataset includes information on whether the host of the listing is a superhost or not. Experienced hosts can become a superhost upon fulfillin certain criteria, such as having a low cancellation rate, a high response rate as well as a high overall rating based on the last 365 days [[Source airbnb]](https://www.airbnb.co.uk/help/article/829/how-do-i-become-a-superhost?_set_bev_on_new_domain=1631260549_OThiYmUyZjJhOGFk).

![Conceptual model](https://user-images.githubusercontent.com/89775376/136206806-efc33fdf-0bee-4a14-beb6-8625d0972de1.png)

**Results**

The results of this study are presented in a PDF report. This is an useful and accessible way of showing the results. 

<!---
Second, summarize your results concisely. Make use of subheaders where appropriate.

--> 
## Repository overview
In this repository there is a Make-file that has to run to make all the maps up to date. All the scripts in this repository will run automatically with the Make-file 
More information on the running of the make file can be found in the running instructions paragraph.

The maps that can be found in this repository are:

**Source**

In the map source ("src") the code to prepare the date is stored.

<!---
Provide an overview of the directory structure and files.
--> 
## Running instructions
To run the files [Make](https://tilburgsciencehub.com/get/make) is needed . The directory works with make which should be run. Make sure to run the Make-file.
Also [R-studio](https://tilburgsciencehub.com/get/r) is needed to run the R-files. 
To run the code used in the study, the following packages need to be installed first:
```
install.packages("readr")
install.packages("dplyr")
install.packages("tidyverse")
install.packages("haven")
install.packages("googledrive")
install.packages("ggplot2")
install.packages("fixest")
install.packages("broom")
install.packages("modelsummary")
install.packages("rlist")
```

<!---
Explain to potential users how to run/replicate your workflow. Touch upon, if necessary, the required input data, which (secret) credentials are required (and how to obtain them), which software tools are needed to run the workflow (including links to the installation instructions), and how to run the workflow. Make use of subheaders where appropriate.
-->
## Resources
The moderators can influence the relationship between the dependent variable and the independent variable. Each moderator can have a different effect. There are different studies that focus on either city size, room type, superhost or AirBnB in general.

The city size can influence the amount of reviews a listing gets because of the people it attracts. Coyle and Yeung (2016) found that AirBnB listings in smaller cities bring more tourism to local communities, who otherwise would not come there. Whereas big and medium cities have listings that are more for economic and administrative functions (Adamiak et al. 2019). Big cities usually have more activities and more noise, according to Cheng and Jin (2019) this can lead to less (positive) reviews. 

The room type can also influence the amount of review a listing gets. The size of a city influences the room type. Big and medium cities usually have more hotel rooms, private rooms, or shared rooms, whereas small cities have more entire homes (Adamiak et al. 2019). The room type, and the people who chose fore a certain room type, can influence the probability that they write a review for the listing.

The status “Superhost” has an effect on the number of reviews and rating a listing gets (Liang et al. 2017). When a host has different qualities, such as a personal profile picture, it gets a superhost badge. The qualities make people trust them more and because of that they are more likely to leave reviews (Fleischer and Magen 2016; Liang et al. 2017). 

There are multiple studies that focus on reviews on AirBnB. Studies worth mentioning are:
- Bridges, J., & Vásquez, C. (2018). If nearly all Airbnb reviews are positive, does that make them meaningless?. Current Issues in Tourism, 21(18), 2057-2075.
  In the study the authors find that AirBnB reviews appear to be highly positive and therefor quite similar to one another. If reviews are quite similar, what is the added value that reviews bring to one listing? 
- Ert, E., Fleischer, A., & Magen, N. (2016). Trust and reputation in the sharing economy: The role of personal photos in Airbnb. Tourism management, 55, 62-73.
Fleischer and Magen find that the more trustworthy a host is perceived on their profile picture, the higher the price of the listing can be, and the probabilty of the listing being chosen. Furthermore, they find that the host's reputation, their online review scores, has less effect on the price or booking.
- Liang, S., Schuckert, M., Law, R., & Chen, C. C. (2017). Be a “Superhost”: The importance of badge systems for peer-to-peer rental accommodations. Tourism management, 60, 454-465. This study focuses on the label "Superhost", a label that is given by AirBnB for a host with certain qualities, and how this label can impact listings review volume and ratings. "Superhosts" are more likely to receive reviews and higher ratings and guest are willing to pay more for these listings.
- Coyle, D., & Yeung, T. (2016). Understanding Airbnb in fourteen European cities. The Jean-Jacques Laffont Digital Chair Working Papers, 7088, 1-33.
- Adamiak, C., Szyda, B., Dubownik, A., & García-Álvarez, D. (2019). Airbnb offer in Spain—spatial analysis of the pattern and determinants of its distribution. ISPRS International Journal of Geo-Information, 8(3), 155.

<!---

Point interested users to any related literature and/or documentation.
-->
## About

This study is conducted by project group 2 of the [Data Preparation and Workflow Management course](https://github.com/hannesdatta/course-dprep) of the TISEM department of Tilburg University. 
The project is done in the fall 2021 version of the course. The project was part of a team project performed by Marketing Analytics master students. Professor [Hannes Datta](https://github.com/hannesdatta) contributed by providing helpful feedback during project feedback meetings.
The data used for this project is available at [Inside AirBnB](http://insideairbnb.com/get-the-data.html)
  

## Contributors
Team members: [Doria Wengting Wang](https://github.com/DoriaWW), [Inge Oostveen](https://github.com/IngeOostveen), [Ralph Delsing](https://github.com/RalphGit21), [Paulus Hovens](https://github.com/pphovens), [Wouter Floors](https://github.com/WouterFloors)

