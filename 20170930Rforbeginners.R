# Sunum 10, "Ortalama" Uygulama
  x <- rnorm(n = 20,
             mean = 10,
             sd = 1) # Aykiri degerler az, Stdev dusuk.
  plot(x)
  mean(x)
  abline(a = mean(x),b = 0,col = "red")
  legend("topright",
         legend =c("Mean"),
         lty=c(1), 
         lwd=c(2.5),
         col=c("red"))
  
# Sunum 13, "Median" Uygulama
  x1 <- rnorm(n = 20,
             mean = 10,
             sd = 1) # Aykiri degerler fazla, Stdev buyuk.

  x2 <- rnorm(n = 20,
             mean = 20,
             sd = 10) # Aykiri degerler fazla, Stdev buyuk.
  
  x <-c(x1,x2)
  
  plot(x)
  median(x)
  mean(x)
  abline(a = mean(x),b = 0,col = "red")
  abline(a = median(x),b = 0,col = "blue")
  legend("topright",
         legend =c("Mean","Median"),
         lty=c(1,1), 
         lwd=c(2.5,2.5),
         col=c("red","blue"))
  
# Sunum 15, "Mod" Uygulama
  # Gozlemlerin mod degerini bulmak icin R'da Built-in paket fonksiyonu bulunmamaktadir.
  # "modeest" paketinden yararlanilabilir. Ref: https://www.rdocumentation.org/packages/modeest/versions/2.1/topics/mlv
  require("modeest")
  
  x <- c(19, 4, 5, 7, 29, 19, 29, 13, 25, 19)
  mlv(x , method = "mfv")
  ModeModel <- mlv(x , method = "mfv") # mfv:  most frequent value(s)
  ModeX <- ModeModel$M
  ModeX
  plot(x)
  abline(a = ModeX,b = 0,col="red")  
  legend("topleft",
         legend =c("Mod"),
         lty=c(1), 
         lwd=c(2.5),
         col=c("red"))
  
    
# Sunum 20, Geometrik Ortalama - Aritmetik Ortalama Karsilastirma
  # Degisim Orani (hizi)=1+r=Sonraki deger/Onceki deger

  DegisimOrani <- function(x){
    ValueLength <- length(x)
    ChangeRate <- rep(0,ValueLength-1)
    for(i in 2:ValueLength){
      ChangeRate[i-1] <- x[i] / x[i-1]
    }
    return(ChangeRate)
  }
  
  AritmetikOrt <- function(x){
    return( round(mean(x),2) ) 
  }
  
  GeometrikOrt <- function(x){
    return( round(sqrt(prod(x)),2) ) 
  }
  
  # Ornek,
  Oranlar <- DegisimOrani(c(15000,30000,120000))
  GeometrikBuyumeHizi <-GeometrikOrt(Oranlar)
  AritmetikBuyumeHizi <-AritmetikOrt(Oranlar)
  
  print(Oranlar)
  print(GeometrikBuyumeHizi)
  print(AritmetikBuyumeHizi)
  
  # Geometrik
  GeometrikTahmin_2010 <- GeometrikBuyumeHizi * 15000
  GeometrikTahmin_2011 <-  GeometrikBuyumeHizi * GeometrikTahmin_2010
  print(GeometrikTahmin_2010)
  print(GeometrikTahmin_2011)
  # Aritmetik
  AritmetikTahmin_2010 <- AritmetikBuyumeHizi * 15000
  AritmetikTahmin_2011 <-  AritmetikBuyumeHizi * AritmetikTahmin_2010
  print(AritmetikTahmin_2010)
  print(AritmetikTahmin_2011)
  
# Sunum 24, Harmonik Ortalama
  HarmonikOrt <- function(x){
        return(1/mean(1/x)) # Harmonik Ortalama
  }
  EtFiyatlari <- c(20,25,28,32)
  Harmonik    <- HarmonikOrt(EtFiyatlari)
  Aritmetik   <- mean(EtFiyatlari)
  
  plot(EtFiyatlari,type = "o")
  abline(a = Harmonik,b = 0,col ="red" )
  abline(a = Aritmetik,b = 0,col ="blue" )
  legend("topleft",
         legend =c("Harmonik","Aritmetik"),
         lty=c(1,1), 
         lwd=c(2.5,2.5),
         col=c("red","blue"))

# Sunum 30, Kartil, Desil ve Santiller
  # Kartiller,
  scores <- c(88, 84, 83, 80, 94, 90, 81, 79, 79, 81, 85, 87, 86, 89, 92)
  quantile(scores)
  
  # Desiller,
  weights <- c(69, 70, 75, 66, 83, 88, 66, 63, 61, 68, 73, 57, 52, 58, 77)
  quantile(weights, prob = seq(0, 1, length = 11), type = 5)
  
  # Santil,
  heights <- c(24, 44, 14, 45, 36, 48, 77, 85, 56, 15, 34, 70, 51, 75, 83)
  quantile(heights, prob = 0.30) # 30. Santil
  
# Sunum 46, 3 ve 4. Momentler (Asimetri Olculeri)
  Moment.mean <- function(x) {
    # compute the observed moments of x around the mean
    n <- length(x)
    mean <- sum(x)/n
    M <- c()
    M[1] <- sum((x - mean)^1)/n
    M[2] <- sum((x - mean)^2)/n
    M[3] <- sum((x - mean)^3)/n
    M[4] <- sum((x - mean)^4)/n
    
    return(M)
  }
  
  Skewness <- function(x) {
    # compute skewness
    Skew <- Moment.mean(x)[3]/(Moment.mean(x)[2])^(3/2)
    
    return(Skew)
  }
  
  Kurtosis <- function(x) {
    Kurt <- (Moment.mean(x)[4]/(Moment.mean(x)[2]^2))
    
    return(Kurt)
  }
  
  set.seed(123) # Generate Random seed 123
  x <- rnorm(1000,mean = 0,sd = 1)
  NormalSkew <- Skewness(x)
  NormalKurt <- Kurtosis(x)
  
  print(NormalSkew) # NormalSkew ~= 0 ise seri simetrik
  print(NormalKurt) # NormalKurt ~= 3 ise seri normal
  
  hist(x)


# Sunum 57, Histogramlar
  str(airquality)
  Temperature <- airquality$Temp
  
  hist(Temperature)
  hist(Temperature,breaks = 100) # breaks parametresi
  
  hist(Temperature,
       main="Maximum daily temperature at La Guardia Airport",
       xlab="Temperature in degrees Fahrenheit",
       xlim=c(50,100),
       col="darkmagenta",
       freq=FALSE
  )  

# Sunum 64, Box-Plot
  
  boxplot(mpg~cyl,
          data=mtcars, 
          main="Car Milage Data", 
          xlab="Number of Cylinders", 
          ylab="Miles Per Gallon")

  boxplot(wt~cyl, 
          data=mtcars, 
          main=toupper("Vehicle Weight"), 
          xlab="Number of Cylinders", 
          ylab="Weight", 
          col="darkmagenta")
  
