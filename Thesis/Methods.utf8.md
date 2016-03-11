---
header-includes:
- \usepackage{graphicx,latexsym}
- \usepackage{amssymb,amsthm,amsmath}
- \usepackage{longtable,booktabs,setspace}
- \usepackage{tikz}
- \usepackage{setspace}
output: pdf_document
---
\onehalfspacing






# Methods

The primary goals of this analysis are to 1) offer a better understanding of the characteristics and use patterns of patients at urgent care centers and 2) to examine empirically the differences between these individuals and those who continue to use traditional means of healthcare. Given these dual interests, the anlaysis was performed in three stages. First, an exploratory cluster analysis was performed on an abundance of patient chracteristics for those who were coded as having gone to urgent care centers. Second, the results of the cluster analysis were used to inform a logistic regression analysis which examines the significant indicators which have an affect on whether a patient will make the initial decision to go to urgent care over traditional primary care. Third, a secondary regression analysis was performed to determine differences between patients using urgent care as primary care and those who do not. 

## Data

An empirical exploration of the hypotheses proposed in chapter two requires data that provides an abundance of variables which may or may not be statistically important but which we cannot initally rule out, as well as a large sample size since the phenomenon is still comparatively rare when thinking about how patients access primary care in the US. Given these initial requirements, I thus chose the National Ambulatory Medical Care Survey (NAMCS), which is a national survey designed and distributed by the American Center for Disease Control (CDC) to provide researchers in the medical and social science fields "accurate and reliable information about the provision and use of ambulatory medical care services in the United States" [@namcs]. 

For those unfamiliar with healthcare lingo, ambulatory care is defined by the survey as health services or acute care services provided to patients on an outpatinet basis (without an overnight stay). Once a year NAMCS surveys randomly selected visits to non-federal employed office-based physicians, which are collected from a representative sample of the United States' medical care facilities. These surveys record ovar 500 variables on information about how the patients utilize physician services, the conditions most often treated, and the diagnostic and therapeutic services rendered, including medications prescribed. Because it is both representative of the larger trends in the United States and includes specific information regarding urgent care centers which can be used to explore that particular American health care trend in particular, the dataset serves the purposes of the current study quite well.  

Some limitations to the data should be noted. There may be related errors given that as the popularity of urgent care centers have risen, so too have the number that participated in the NAMCS. In 2008, there were 842 visits surveyed compared to 1168 surveyed in 2010. There may also be a compoundinf factor of selection: many urgent care centers are classified as retail clinics by the CDC, and are thus not included in the NAMCS random selection pool. Even with these limitations, the CDC specifcally offers the NAMCS as a tool for social scientists, and this analysis depends on their collection methods being statistically expandable. 


## Variable Selection and Summary Statistics

The NAMCS is a large dataset: compiling observations for the years 2008-2012 generated a dataset of over 100,000 observations with 547 variables. 


I began the analysis by utilizing unsupervised statistical learning methods in order to develop descriptive categories of urgent care center patients. The pros of performing an initial analysis of this nature are its ability to efficiently examine a large amount of variables and highlight those that should be included in the analysis. This was motivated by the current lack of statistical analysis and social theory surroundding urgent care centers, which makes it difficult to develop a model from scratch. he results of the clustering act as a guide for the regression techniques by identifying variables with some relationship to urgent care.

For the clustering, I examined the group of visits which were coded as having been at "Urgent Care Centers/Freestanding Clinics" by the NAMCS. While the combined years produced a dataset of 123,123 (not kidding) observations, only 3,863 of those occurred at urgent care centers (about 3 percent). Of these visits, I limited the analysis to patients over the age of 18, bringing the sample to 3,224 visits to urgent care centers.

### Patient and Visit Characteristics

Many of the variables chosen to include in the exploratory cluster analysis were selected with an awareness of the historical and sociological understandings of the decision factors which affect how Americans choose their healthcare. Patient demographics including age, race, gender, and socioeconomic status indicators were included, along with regional data for each visit and variables which examined the type and history of the visits to the facility. 


Inital clusters included dummy variables for self-pay, private insurance, race (white, black, hispanic, asian, 2+), sex, rural, and wealthy. To identify the subsets, I took random samples from the cases which were recording as having been at urgent care centers using the dplyr package sample_n, which allows for a random campling of rows from a table. from the cases which were recording as having been at urgent care centers. For the three years in question a total of 2459 visits to urgent care were surveyed. In order to get workable training data for the unsupervised clustering, I set aside a random sample of 250 visits for test data, and proceeded to randomly sample from the 2209 cases available, running the analysis on 250 observations at a time. 


## *k*-Modes Cluster Analysis

This method allows for grouping patients that have similar characteristics across a set of variables by dividing a set of cases into ever more numerous and specific subsets, thus leading to homogenous empirical types (Rapkin and Luke, 1993). One of the most powerful exploratory aspects of cluster analysis is that you do not need to have a response variable in order to better understand your data. For this project, this is extremely useful since we initially only know who is going to urgent care and who is not, but would like to understand them as a group better before drawing comparisions between patients who visited a traidtional primary care clinic. Also a plus for cluster analysis, such inductive methodologies are based only on quantitative similarities among cases, only two factors may be responsible for trends in the data: the actual structure of the observed phenomenon and the methodological decisions I made concerning choosing the cases and variables (inclduing the statistical method used to identify subsets). 

Because I am interested in two somewhat distinct aspects of the patients of Urgent Care-- both their demographics and their patterns of use -- The clustering was performed in two batches of parameters which aimed to help us understand the two different side to a visit to urgent care. Variables for *Age, Sex, Race, Urban Type, % Neighborhood Poverty, % Neighborhood college degree attainment, and Pay Type*, what I will refer to as the *demographic variables* from this point forward were first analyzed for subgroups. Secondly, some of the same variables were again analyzed with the behavior parameters of *Injury related, Primary Caregiver, Seen Before?, Past Visits, Major Reason, and the day of the week*, what I will refer to as the *behavior parameters*. 

While clustering methods are incresingly being used to generate scientific hypotheses, this analysis rather aims to apply clustering as a method of retroduction on a phenomenon that is currently vastly under studied. The methodological decisions of this study are divided into three areas: (1) the determination of the number of clusters, (2) the examination of how the clusters differ in terms of multiple parameters, and (3) examining the clusters in light of the theoretical hypotheses posed in the introduction. 

 **from jess**
 
Because I am particularly interested in two somewhat individual facets of the patients of urgent care—both their demographics and their patterns of use—the clustering was performed in two batches of parameters which aimed to help develop an understanding of the two components which are involved in a visit to urgent care[WHOA TORTURNED SENTENCE] . Variables for Age, Sex, Race, Urban Type, % Neighborhood Poverty, % Neighborhood college degree attainment, and Pay Type, which I will refer to as the demographic variables from this point forward, were first analyzed for subgroups.

Subsequently, some of the same variables were again analyzed with the parameters of Injury related, Primary Caregiver, Seen Before, Past Visits, Major Reason, and the day of the week, which I will refer to as the behavior parameters. *[FYI, you should have a section of your methods discussion dedicated to explaining each of these variables.]*





\newpage 
## Summary Table

\singlespacing

Table: Summary Statistics 1 \label{tab:sums}

Variable         Category                              Percentage 
---------------  ------------------------------------  -----------
Sex                                                               
                 Female                                57.1       
                 Male                                  42.9       
AgeGroup                                                          
                 15-24 years                           8.68       
                 25-44 years                           22.89      
                 45-64 years                           29.63      
                 65-74 years                           13.93      
                 75 years and over                     12.58      
                 Under 15 years                        12.3       
Race                                                              
                 Black                                 9.15       
                 Other                                 3.87       
                 White                                 86.98      
PaymentType                                                       
                 All sources of payment are blank      0.44       
                 Medicaid                              10.67      
                 Medicare                              26.37      
                 No charge                             0.58       
                 Other                                 3.07       
                 Private insurance                     46.9       
                 Self-pay                              4.86       
                 Unknown                               1.93       
                 Worker's compensation                 5.17       
UrbanCategory                                                     
                 Large central metro                   24.6       
                 Large fringe metro                    14.62      
                 Medium metro                          34.55      
                 Micropolitan/noncore (nonmetro)       15.98      
                 Missing data                          0          
                 Small metro                           10.25      
PercentPoverty                                                    
                 Missing data                          0          
                 Quartile 1 (Less than 5.00 percent)   18.16      
                 Quartile 2 (5.00-9.99 percent)        30.24      
                 Quartile 3 (10.00-19.99 percent)      39.22      
                 Quartile 4 (20.00 percent or more)    12.38      

Below are the summary statistics for an example sample:

```r
summarize_each(sample1, funs(mean))
```
#### insert table here


### Logistic Model Dependant Variable
\onehalfspacing
The dependant variable analyzed in the logistic model in this study is wheter or not a patient went to urgent care. Furthermore, a secondary analysis is conducted on how the patient demographics and visit chracteristics relate to whether or not the patient uses urgent care as their primary care physician. Both of these outcome variables are analyzed in light of many visit level chracteristics, up to 16 in the full logistic model. 


