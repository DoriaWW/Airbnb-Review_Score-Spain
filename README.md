# To review or not to review? That's the question

__Does the number of reviews that your listing is getting on AirBnB affect the actual review score? Does this effect differ between big or small cities in Spain?__

<p align="center">
  <img src="https://s3.amazonaws.com/blog4.0/blog/wp-content/uploads/Feature-Image_The-Ultimate-Guide-to-Airbnb-Reviews@2x-scaled.png" width="70%" />
</p>

## Motivation

We all know the feeling of opening an e-mail that asks you to leave a review on a product that you just bought or a listing that you stayed the night at. But do more reviews lead to a higher review score? Furthermore, this effect is examined at cities in Spain that differ in sizes, such as Malage compared to the capital Madrid. This code is written in order to find answers to these questions.

## Method and results

First, introduce and motivate your chosen method, and explain how it contributes to solving the research question/business problem.

The relationship between the number of reviews and actual review score may be influenced by other variables, which are integrated in the model as moderators. In this study, three moderators are considered: 
1) The city size which is encoded using dummy variables. Each of the seven cities in Spain falls in either one of three categories; Big, Medium or Small, depending on the number of residents. 
2) Room type 
3) Host characteristics. This variable is measured by taking the average of the sum of various different characteristics of the host, which are the response time, response rate, host location and number of host listings. 

Second, summarize your results concisely. Make use of subheaders where appropriate.

<!---
## Repository overview

Provide an overview of the directory structure and files.
-->
## Running instructions
To run the files [Make](https://tilburgsciencehub.com/get/make) is needed . The directory works with make which should be run. Also [R-studio](https://tilburgsciencehub.com/get/r) is needed to run the R-files. 
First, an overview of the packages used in this study is given:
```
install.packages("readr")
install.packages("readxl")
install.packages("dplyr")
install.packages("tidyverse")
```

<!---
Explain to potential users how to run/replicate your workflow. Touch upon, if necessary, the required input data, which (secret) credentials are required (and how to obtain them), which software tools are needed to run the workflow (including links to the installation instructions), and how to run the workflow. Make use of subheaders where appropriate.

## More resources

Point interested users to any related literature and/or documentation.
-->
## About

This study is conducted by project group 2 of the [Data Preparation and Workflow Management course](https://github.com/hannesdatta/course-dprep) of the TISEM department of Tilburg University. 
The project is done in the fall 2021 version of the course. The project was part of a team project performed by Marketing Analytics master students. Professor [Hannes Datta](https://github.com/hannesdatta) contributed by providing helpful feedback during project feedback meetings.

## Contributors
Team members: [Doria Wengting Wang](https://github.com/DoriaWW), [Inge Oostveen](https://github.com/IngeOostveen), [Ralph Delsing](https://github.com/RalphGit21), [Paulus Hovens](https://github.com/pphovens), [Wouter Floors](https://github.com/WouterFloors)

