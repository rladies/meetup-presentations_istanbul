R-Ladies Istanbul: R For Beginners
========================================================
author: Hazel Kavili
date: 2017-09-30
width: 1400
height: 1280
font-family: 'Helvetica'



R and R Studio
========================================================

Let's meet with the most used IDE (integrated desktop environment) for R

- Scripts, Console,
  - Code and workflow are more reproducible if we can document everything that we do.
- Environment, History, Connections
- Files, Plots, Packages, Help, Viewer
  - The viewer window will helpy ou to see Plots, Shiny applications, blog pages of you did!

Looking for Help!
========================================================
- Ask Google
- Search in [Stackoverflow](https://stackoverflow.com/questions/tagged/r)
- [An introduction to R](http://cran.us.r-project.org/doc/manuals/R-intro.pdf)
- [R for Data Science](http://r4ds.had.co.nz) book from Hadley Wickham & Garrett Grolemund
- [Try R](http://tryr.codeschool.com)
- R mailing list: first, learn how to ask questions!
- [R Tutorials](http://www.tutorialspoint.com/r/)
- Get help from R:


```r
help.start()
help(mean)
?mean
example(mean)
```

Getting Started - I
========================================================
### **Motor Trend Car Road Tests - simple dataset**

```r
head(mtcars)
```

```
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

```r
tail(mtcars)
```

```
                mpg cyl  disp  hp drat    wt qsec vs am gear carb
Porsche 914-2  26.0   4 120.3  91 4.43 2.140 16.7  0  1    5    2
Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.9  1  1    5    2
Ford Pantera L 15.8   8 351.0 264 4.22 3.170 14.5  0  1    5    4
Ferrari Dino   19.7   6 145.0 175 3.62 2.770 15.5  0  1    5    6
Maserati Bora  15.0   8 301.0 335 3.54 3.570 14.6  0  1    5    8
Volvo 142E     21.4   4 121.0 109 4.11 2.780 18.6  1  1    4    2
```

Getting Started - II
========================================================
### **Teaching base or tidyverse way**

Base R codes:

```r
mtcars$transmission <- 
  ifelse(mtcars$am == 0, "automatic", "manual")
```

dplyr codes:

```r
mtcars <- mtcars %>%
  mutate(transmission = case_when(am == 0 ~ "automatic", am == 1 ~ "manual"))
```

Getting Started - III
========================================================
### **Teaching base or tidyverse way**
#### **Visualisation**
Base R codes:

```r
mtcars$trans_color <- 
  ifelse(mtcars$transmission == "automatic", "green", "blue")

pdf("plots/scatter_base.pdf", width = 5, height = 3)
plot(mtcars$mpg ~ mtcars$disp, col = mtcars$trans_color)
legend("topright", 
       legend = c("automatic", "manual"), 
       pch = 1, col = c("green", "blue"))
dev.off()
```

ggplot codes:

```r
p1 <- ggplot(mtcars, aes(x = disp, y = mpg, color = transmission)) +
       geom_point()

ggsave("plots/scatter_tidy.pdf", p1, width = 5, height = 3)
```


Getting Started - IV
========================================================

**R commands:**
- are case sensitive
- can be seperated either by a semi-colon(;), or by a newline
- #comment

**Objects:**
- varibables, arrays of numbers, character strings, functions

Getting Started - V
========================================================

**Assignment**  and **Basic Operators**
- use **<-** for assigments
- +,-, *, /, ^, %%

**Logical Operators**
- <,>, <=, >=, ==, !=, !x, x & y, x | y

**Others**
- sum, sqrt, min, max, mean, var, sd, abs, summary

Most Frequently Used Objects
========================================================
- Vectors
- List
- Matrices
- Arrays
- Factors
- Data Frames

Vectors
========================================================
- use **c()** for concatenate more than one element.
- in programming vectors are variable sized sequence of values (not necessarily numbers).

```r
books <- c("history", "sci-fi", "fantasy")
print(books)
```

```
[1] "history" "sci-fi"  "fantasy"
```

```r
print(class(books))
```

```
[1] "character"
```

```r
ages <- c(12,13,14,15,9,8)
print(ages)
```

```
[1] 12 13 14 15  9  8
```

```r
print(class(ages))
```

```
[1] "numeric"
```



Examples
========================================================

```r
#this is R-Ladies Istanbul
X <- 10
x <- 5
print(paste("X is", X))
```

```
[1] "X is 10"
```

```r
print(paste("x is", x))
```

```
[1] "x is 5"
```

```r
cat("X and x are equal? = ", X == x)
```

```
X and x are equal? =  FALSE
```


```r
myNumbers <- c(1:10) # c is short for concatenate
rep(myNumbers, times = 3)
```

```
 [1]  1  2  3  4  5  6  7  8  9 10  1  2  3  4  5  6  7  8  9 10  1  2  3
[24]  4  5  6  7  8  9 10
```

```r
twice <- rep(myNumbers, each = 2)
print(twice)
```

```
 [1]  1  1  2  2  3  3  4  4  5  5  6  6  7  7  8  8  9  9 10 10
```

Examples - II
========================================================

```r
y <- c(1,2,3,10,15,20)
z <- c(y,4,5,6,y)
print(y)
```

```
[1]  1  2  3 10 15 20
```

- Vector Arithmetic

```r
5/y
```

```
[1] 5.0000000 2.5000000 1.6666667 0.5000000 0.3333333 0.2500000
```

```r
5*y
```

```
[1]   5  10  15  50  75 100
```

```r
y^2
```

```
[1]   1   4   9 100 225 400
```

```r
sqrt(y)
```

```
[1] 1.000000 1.414214 1.732051 3.162278 3.872983 4.472136
```

Examples - III
========================================================

```r
seq(from = -10, to = 10, by = 1)
```

```
 [1] -10  -9  -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5   6
[18]   7   8   9  10
```

```r
seq(from = 1, length = 25, by = 2 )
```

```
 [1]  1  3  5  7  9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45
[24] 47 49
```

Simple Manipulations
========================================================


```r
weights <- c(55, 60, 45, 70, 56, 73, 59, 82)
sum(weights)
```

```
[1] 500
```

```r
mean(weights)
```

```
[1] 62.5
```

```r
sd(weights)
```

```
[1] 11.77164
```

```r
var(weights)
```

```
[1] 138.5714
```

```r
length(weights)
```

```
[1] 8
```

Lists
========================================================
- Lists can contain many different types of elements inside.

```r
myList <- list(c(1,2,3), 15, "hello")
print(myList)
```

```
[[1]]
[1] 1 2 3

[[2]]
[1] 15

[[3]]
[1] "hello"
```

- Select an element from lists

```r
myList[1]
```

```
[[1]]
[1] 1 2 3
```

```r
myList[[1]][2]
```

```
[1] 2
```

```r
myList[2]
```

```
[[1]]
[1] 15
```


Matrices
========================================================
- A matrix is **two-dimensional** recteangular data set.

```r
myMatrix <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3, byrow = TRUE)
print(myMatrix)
```

```
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
```

- Select an element from matrices

```r
myMatrix[1,2]
```

```
[1] 2
```

```r
myMatrix[2,]
```

```
[1] 4 5 6
```

```r
myMatrix[,1]
```

```
[1] 1 4
```

```r
dim(myMatrix)
```

```
[1] 2 3
```

Matrices - II
========================================================

```r
myMatrix2 <- matrix(c(-6:-1), nrow = 2, ncol = 3, byrow = TRUE)
myMatrix + myMatrix2
```

```
     [,1] [,2] [,3]
[1,]   -5   -3   -1
[2,]    1    3    5
```

```r
myMatrix %*% c(1,2,3)
```

```
     [,1]
[1,]   14
[2,]   32
```

```r
diag(myMatrix2) #diagonal    
```

```
[1] -6 -2
```

```r
t(myMatrix2)  #transpose of matrix
```

```
     [,1] [,2]
[1,]   -6   -3
[2,]   -5   -2
[3,]   -4   -1
```


Arrays
========================================================
- Arrays can be of any number of dimensions

```r
myArray <- array(c('uno','dos', 'tres'), dim = c(3,3,3))
print(myArray)
```

```
, , 1

     [,1]   [,2]   [,3]  
[1,] "uno"  "uno"  "uno" 
[2,] "dos"  "dos"  "dos" 
[3,] "tres" "tres" "tres"

, , 2

     [,1]   [,2]   [,3]  
[1,] "uno"  "uno"  "uno" 
[2,] "dos"  "dos"  "dos" 
[3,] "tres" "tres" "tres"

, , 3

     [,1]   [,2]   [,3]  
[1,] "uno"  "uno"  "uno" 
[2,] "dos"  "dos"  "dos" 
[3,] "tres" "tres" "tres"
```

Factors
========================================================
- They are categorical variables.
- You can create using a vector. Factors stores the vector along with distinct values of the elements in the vector as labesl.
- The labels are always character irrespective of wheter it is numeric or character or Boolean etc. input vector. They are useful in statistical modelling.


```r
myVector <- c('blue', 'red', 'violet', 'red', 'red', 'blue')
print(myVector)
```

```
[1] "blue"   "red"    "violet" "red"    "red"    "blue"  
```

```r
myVectorFactor <- factor(myVector)
print(myVectorFactor)
```

```
[1] blue   red    violet red    red    blue  
Levels: blue red violet
```

```r
print(nlevels(myVectorFactor))
```

```
[1] 3
```

Tidy Data Concept and Data Frames
========================================================
**Tidy Data**
- Each variable forms a column
- Each observation forms a row
- Each type of observational unit forms a table


```r
mySurvey <- data.frame(
  name = c("Harry", "Ron", "Hermione", "Draco", "Cedric"),
  gender = c("Male", "Male", "Female", "Male", "Male"),
  age = c(11, 11, 11, 11, 12),
  bloodStatus = c("Half-blood", "Pure-blood","Muggle-born", "Pure-blood", NA),
  house = c("Gryffindor", "Gryffindor", "Gryffindor", "Slytherin", NA)
  )
print(mySurvey)
```

```
      name gender age bloodStatus      house
1    Harry   Male  11  Half-blood Gryffindor
2      Ron   Male  11  Pure-blood Gryffindor
3 Hermione Female  11 Muggle-born Gryffindor
4    Draco   Male  11  Pure-blood  Slytherin
5   Cedric   Male  12        <NA>       <NA>
```

Indexing, Selecting and Modifying
========================================================


```r
is.na(mySurvey)
```

```
      name gender   age bloodStatus house
[1,] FALSE  FALSE FALSE       FALSE FALSE
[2,] FALSE  FALSE FALSE       FALSE FALSE
[3,] FALSE  FALSE FALSE       FALSE FALSE
[4,] FALSE  FALSE FALSE       FALSE FALSE
[5,] FALSE  FALSE FALSE        TRUE  TRUE
```

```r
mySurvey[5,4] <- "Pure-blood"
str(mySurvey)
```

```
'data.frame':	5 obs. of  5 variables:
 $ name       : Factor w/ 5 levels "Cedric","Draco",..: 3 5 4 2 1
 $ gender     : Factor w/ 2 levels "Female","Male": 2 2 1 2 2
 $ age        : num  11 11 11 11 12
 $ bloodStatus: Factor w/ 3 levels "Half-blood","Muggle-born",..: 1 3 2 3 3
 $ house      : Factor w/ 2 levels "Gryffindor","Slytherin": 1 1 1 2 NA
```

```r
levels(mySurvey$house) <- c("Gryffindor", "Slytherin", "Hufflepuff")
mySurvey[5,5] <- "Hufflepuff"
print(mySurvey)
```

```
      name gender age bloodStatus      house
1    Harry   Male  11  Half-blood Gryffindor
2      Ron   Male  11  Pure-blood Gryffindor
3 Hermione Female  11 Muggle-born Gryffindor
4    Draco   Male  11  Pure-blood  Slytherin
5   Cedric   Male  12  Pure-blood Hufflepuff
```

Indexing, Selecting and Modifying - II
========================================================

```r
mySurvey$name
```

```
[1] Harry    Ron      Hermione Draco    Cedric  
Levels: Cedric Draco Harry Hermione Ron
```

```r
head(mySurvey)
```

```
      name gender age bloodStatus      house
1    Harry   Male  11  Half-blood Gryffindor
2      Ron   Male  11  Pure-blood Gryffindor
3 Hermione Female  11 Muggle-born Gryffindor
4    Draco   Male  11  Pure-blood  Slytherin
5   Cedric   Male  12  Pure-blood Hufflepuff
```

```r
tail(mySurvey)
```

```
      name gender age bloodStatus      house
1    Harry   Male  11  Half-blood Gryffindor
2      Ron   Male  11  Pure-blood Gryffindor
3 Hermione Female  11 Muggle-born Gryffindor
4    Draco   Male  11  Pure-blood  Slytherin
5   Cedric   Male  12  Pure-blood Hufflepuff
```
- look for:

```r
x %in% y, !(x %in% y), !x, !is.na()
```

R Packages
========================================================
- R has a lot of packages for you to make some work easily done!
- **CRAN** is the name of the R package repository but you can find and download many R packages on Github.
- These packages are about: statistics, modelling, visualisation, manipulating, documentation, making websites/applications etc.

Tidyverse
========================================================
- dplyr, broom, tidyr, lubridate 
- ggplot2
- purrr, magrittr, forecats, tibble
- readxl

Installation 
========================================================


```r
install.packages('tidyverse')
library(tidyverse)
```


Datasets
========================================================
- R has many example datasets and you can look at the list of datasets from [here](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html) to make practice.
- Today we will use **20170930dataset** and learn how to load a data set on working directory and manipulate it with **dplyr** functions. 

  - To read a dataset, you can use these functions, according to your file type: *read.csv*, *read.table*, *read.xls*, *read.xlsx*  etc.
  - You need **path** of the file: where you store your file. For example *(/Users/hazelkavili/Desktop/R-LadiesIstanbul/20170930dataset.csv)*



```r
myDataset <- read.csv(file = "~/Desktop/R-LadiesIstanbul/20170930dataset.csv", sep = ",", header = TRUE)
print(myDataset)
```

```
   GlobalRank         Company Sales Profits Assets MarketValue
1         307      KocHolding  47.1     1.3   61.1        13.6
2         333       IsBankasi  12.4     1.9  112.7        16.8
3         341  GarantiBankasi   9.8     1.9   99.2        22.0
4         382          Akbank   8.2     1.7   91.6        20.6
5         388  SabanciHolding  14.6     1.0   98.3        12.7
6         543        Halkbank   6.2     1.5   61.0        13.3
7         711       VakifBank   6.3     0.8   60.6         7.9
8         802     TurkTelekom   7.1     1.5    9.5        15.0
9         843        Turkcell   5.9     1.2   10.5        14.8
10       1210 TurkishAirlines   8.3     0.6   10.5         4.8
11       1245            Enka   5.7     0.6    8.2         8.3
12       1788     AnadoluEfes   3.6     0.3    6.5         9.0
13       1972             BIM   5.5     0.2    1.2         7.5
14       1977      FordOtosan   5.5     0.4    2.6         4.5
```


Structure of Dataset
========================================================

```r
str(myDataset)
```

```
'data.frame':	14 obs. of  6 variables:
 $ GlobalRank : int  307 333 341 382 388 543 711 802 843 1210 ...
 $ Company    : Factor w/ 14 levels "Akbank","AnadoluEfes",..: 9 8 6 1 10 7 14 11 12 13 ...
 $ Sales      : num  47.1 12.4 9.8 8.2 14.6 6.2 6.3 7.1 5.9 8.3 ...
 $ Profits    : num  1.3 1.9 1.9 1.7 1 1.5 0.8 1.5 1.2 0.6 ...
 $ Assets     : num  61.1 112.7 99.2 91.6 98.3 ...
 $ MarketValue: num  13.6 16.8 22 20.6 12.7 13.3 7.9 15 14.8 4.8 ...
```

```r
summary(myDataset)
```

```
   GlobalRank               Company      Sales           Profits     
 Min.   : 307.0   Akbank        :1   Min.   : 3.600   Min.   :0.200  
 1st Qu.: 383.5   AnadoluEfes   :1   1st Qu.: 5.750   1st Qu.:0.600  
 Median : 756.5   BIM           :1   Median : 6.700   Median :1.100  
 Mean   : 917.3   Enka          :1   Mean   :10.443   Mean   :1.064  
 3rd Qu.:1236.2   FordOtosan    :1   3rd Qu.: 9.425   3rd Qu.:1.500  
 Max.   :1977.0   GarantiBankasi:1   Max.   :47.100   Max.   :1.900  
                  (Other)       :8                                   
     Assets         MarketValue   
 Min.   :  1.200   Min.   : 4.50  
 1st Qu.:  8.525   1st Qu.: 8.00  
 Median : 35.550   Median :13.00  
 Mean   : 45.250   Mean   :12.20  
 3rd Qu.: 83.975   3rd Qu.:14.95  
 Max.   :112.700   Max.   :22.00  
                                  
```

Magical Words from dplyr!
========================================================
- **Variables(columns)**
  - select
  - mutate

- **Observations (rows)**
  - filter
  - arrange

- **Groups**
  - summarise

*look for Hadley's book for more magical words*

 %>% (Pipe) Operator
========================================================
- Basically tells R to take the value of that which is to the left and pass it to the right as an argument.
    - cmd + shft + m
    - kntr + shft + m


```r
library(dplyr)
myDataset %>% filter(MarketValue > 5) %>% summarise(Average = mean(Assets))
```

```
  Average
1    51.7
```

Select
========================================================
- Choosing is not losing! 

```r
select(dataframe, var1, var2, ...)
select(dataframe, 1:4, -2)
```


```r
smallSet <- myDataset %>% select(Company, MarketValue)
print(smallSet)
```

```
           Company MarketValue
1       KocHolding        13.6
2        IsBankasi        16.8
3   GarantiBankasi        22.0
4           Akbank        20.6
5   SabanciHolding        12.7
6         Halkbank        13.3
7        VakifBank         7.9
8      TurkTelekom        15.0
9         Turkcell        14.8
10 TurkishAirlines         4.8
11            Enka         8.3
12     AnadoluEfes         9.0
13             BIM         7.5
14      FordOtosan         4.5
```

- There are also helper functions: **starts_with**, **end_with**, **contains**

Mutate
========================================================
- Deals with info in your data which is not display


```r
mutate(dataframe, newVariable = var1 + var2)
mutate(dataframe, x = a + b, y = x + c)
```


```r
mutateSet <- myDataset %>% mutate(TotalMoney = Assets + Profits)
head(mutateSet)
```

```
  GlobalRank        Company Sales Profits Assets MarketValue TotalMoney
1        307     KocHolding  47.1     1.3   61.1        13.6       62.4
2        333      IsBankasi  12.4     1.9  112.7        16.8      114.6
3        341 GarantiBankasi   9.8     1.9   99.2        22.0      101.1
4        382         Akbank   8.2     1.7   91.6        20.6       93.3
5        388 SabanciHolding  14.6     1.0   98.3        12.7       99.3
6        543       Halkbank   6.2     1.5   61.0        13.3       62.5
```

Filter
========================================================
- Filter out rows, specific type of observation

```r
filter(dataframe, logicaltest)
```


```r
filteredSet <- myDataset %>% filter(Assets < 10 & Profits > 1)
print(filteredSet)
```

```
  GlobalRank     Company Sales Profits Assets MarketValue
1        802 TurkTelekom   7.1     1.5    9.5          15
```

Arrange
========================================================
- Helps order observation (default ascending)


```r
arrange(dataframe, var1)
arrange(dataframe, var1, desc(var2))
```


```r
arrangedSet <- myDataset %>% select(GlobalRank, Company, MarketValue) %>%  arrange(desc(MarketValue))
print(arrangedSet)
```

```
   GlobalRank         Company MarketValue
1         341  GarantiBankasi        22.0
2         382          Akbank        20.6
3         333       IsBankasi        16.8
4         802     TurkTelekom        15.0
5         843        Turkcell        14.8
6         307      KocHolding        13.6
7         543        Halkbank        13.3
8         388  SabanciHolding        12.7
9        1788     AnadoluEfes         9.0
10       1245            Enka         8.3
11        711       VakifBank         7.9
12       1972             BIM         7.5
13       1210 TurkishAirlines         4.8
14       1977      FordOtosan         4.5
```

Summarise
========================================================
- Helps order observation (default ascending)


```r
summarise(dataframe, newVar = expression,. . .)
summarise(dataframe, sum = sum(A), avg = mean(B)..)
```


```r
summarisedSet <- myDataset %>% filter(grepl('Bank', Company) | grepl('bank', Company)) %>% 
  summarise(averageAssets = mean(Assets), averageSales = mean(Sales))

print(summarisedSet)
```

```
  averageAssets averageSales
1         85.02         8.58
```

*look for grepl*


References
========================================================
- Mine Cetinkaya-Rundell's  [Teaching Data Science  to New Users](https://github.com/mine-cetinkaya-rundel/2017-07-05-teach-ds-to-new-user) presentation
- Ismail Sezen's [github](https://isezen.github.io/r-presentation/intro.html)
- [data.world](data.world) for many datasets
- Google :) 
- [Data Carpentary](http://www.datacarpentry.org/)


========================================================
# <center> **Any questions?** </center>

#### - hazel@rladies.org & istanbul@rladies.org
#### - twitter.com/RLadiesIstanbul
#### - meetup.com/rladies-istanbul


