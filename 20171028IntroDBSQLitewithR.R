# RLadies Introduction to Database Consepts & SQLite Demo with R, 28 November 2017
# Check Package install
ifelse(test = require("RSQLite")==FALSE, 
       yes = install.packages("RSQLite"),
       no = "RSQLite installed")

# Step 1: Intro
  # SQLite Connect 
  SQLiteDriver <- dbDriver("SQLite")
  DBPath <- "C:/Users/mekmis/Desktop/SQLite/db/RLadiesTestDB.db"
  RLadiesTestDB <- dbConnect(drv = SQLiteDriver,
                             DBPath,
                             synchronous = NULL)
  
  print(RLadiesTestDB)
  dbListTables(RLadiesTestDB)
  
  # DBSendQuery
  TEST_TABLE <- dbSendQuery(RLadiesTestDB,
                             "SELECT * FROM TEST_TABLE")
  
  print(TEST_TABLE)
  fetch(TEST_TABLE) # n parameter
  print(TEST_TABLE)
  
  # DBGetQuery
  TEST_TABLE <- dbGetQuery(RLadiesTestDB,
                          "SELECT * FROM TEST_TABLE")
  
  
# Step 2: Simple Monte Carlo Simulation
  require("ggplot2")
  require("reshape2")
  
  # Generate 100 values
  returns = rnorm(n = 100, mean = 10, sd = 15)
  
  # plot a histogram
  qplot(returns, geom="histogram",
        binwidth = 5,
        main = "Histogram of returns") 
    
  
  sample(returns,size = 5)
  
  X = matrix(ncol = 5,
             nrow = 10000)
  
  for(i in 1:5) {
    # for each i sample the return 10000 times
    for(j in 1:10000){
      RandomX <- rnorm(n = 100, mean = 10, sd = 15) 
      X[j,i] = mean(RandomX)
    }
  }
  
  # Mean expected 
  apply(X,2,mean)
  
  # Quantile of X[,]
  quantile(X[,1])
  
  # Histogram X[,]
  qplot(X[,1], geom="histogram",
        binwidth = 0.5,
        main = "Histogram of returns") 
    
  # Study Results Number: 1
  Results <- data.frame(STUDY_NUMBER = 1,X)
  
  # Write table
  dbListTables(RLadiesTestDB)
  dbWriteTable(conn = RLadiesTestDB,
               "SIMULATION_RESULTS",
               Results,
               append = FALSE # Table not exist
               )
  
  # Select Results
  SIMULATION_RESULTS <- dbSendQuery(conn = RLadiesTestDB,
                                    "SELECT * FROM SIMULATION_RESULTS")
  
  # fetch 50 Rows
  fetch(SIMULATION_RESULTS,n = 50)
  
  
  ## Results Study Number 2,3,..,10
  StudyNumbers <- 2:10
  for(k in StudyNumbers){
      for(i in 1:5) {
        # for each i sample the return 10000 times
        for(j in 1:10000){
          RandomX <- rnorm(n = 100, mean = 10, sd = 15) 
          X[j,i] = mean(RandomX)
        }
      }
    Results <- data.frame(STUDY_NUMBER = k,X)
    dbWriteTable(conn = RLadiesTestDB,
                 "SIMULATION_RESULTS",
                 Results,
                 append = TRUE # Table already exist
                 )
  }
  
  # Control Studies (DISTINCT STUDY)
  StudyList <- dbGetQuery(conn = RLadiesTestDB,
                          "SELECT DISTINCT STUDY_NUMBER  FROM SIMULATION_RESULTS;")
  
  print(StudyList)
  
  # Control Studies (COUNT(*), GROUP BY, ORDER BY  )
  StudyListWithCount <- dbGetQuery(conn = RLadiesTestDB,
                                    "SELECT STUDY_NUMBER,COUNT(*) 
                                        FROM SIMULATION_RESULTS
                                          GROUP BY STUDY_NUMBER
                                          ORDER BY STUDY_NUMBER ASC;")
  
  print(StudyListWithCount)
  
  # Analyze Attributes: X1, X2, X3, X4, X5
  # AVG() : Group By Averages 
  # AS : Alias, Name
  AnalyzeAttributes <- dbGetQuery(conn = RLadiesTestDB,
                                         "SELECT STUDY_NUMBER,
                                                 AVG(X1) AS MEAN_X1,
                                                 AVG(X2) AS MEAN_X2,
                                                 AVG(X3) AS MEAN_X3,
                                                 AVG(X4) AS MEAN_X4,
                                                 AVG(X5) AS MEAN_X5
                                         FROM SIMULATION_RESULTS
                                         GROUP BY STUDY_NUMBER
                                         ORDER BY STUDY_NUMBER ASC;")
  
  AnalyzeAttributesMelt <- melt(AnalyzeAttributes, 
                                id.var = "STUDY_NUMBER")
  
  ggplot(data = AnalyzeAttributesMelt, 
         aes(x=variable, y=value)) + 
    geom_boxplot(aes(fill=STUDY_NUMBER))