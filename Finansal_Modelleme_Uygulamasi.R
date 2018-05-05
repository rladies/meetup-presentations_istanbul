## 1- Finansal Modelleme Uygulamasi: Oynaklik Tahmini ve Simülasyon
## Hazirlayan: Eren Ocakverdi

## 2- Analizlerde kullanilacak paketler
paketler <- c("rugarch","forecast","tseries","boot","quantmod","Rblpapi","dygraphs","ggplot2","xts","MASS","msm")
#install.packages(paketler) #indirmek için
sapply(paketler, require, character.only = T) #yüklemek için

## 3- Yahoo Finance üzerinden verilerin temin edilmesi
dolar_yahoo<-get.hist.quote(instrument="USDTRY=X",
                            quote="Adj",
                            provider=c("yahoo"),
                            method=NULL,
                            origin="2005-01-03",
                            compression="d",
                            retclass=c("zoo"),
                            quiet=FALSE,drop=FALSE)

#write.zoo(dolar_yahoo,file="C://Users//EREN//desktop//dolar_yahoo.csv",sep=",")
#dolar_yahoo<-read.csv("C://Users//EREN//desktop//dolar_yahoo.csv")
#dates <- dolar_yahoo$Index

## 4- Verileri zaman serisi nesnesine donusturelim
dates <- as.Date(time(dolar_yahoo), format="%m/%d/%Y")
dolar_seviye <- as.xts(x=dolar_yahoo$Adjusted, order.by=dates)

## 5- Dinamik grafik çizelim
dygraph(dolar_seviye) %>% dyRangeSelector()

## 6- Ardisik iki gün arasindaki iliskiye bakalim
seviyeler <- na.omit(merge(dolar_seviye,lag(dolar_seviye,k=1)))
colnames(seviyeler) = c("Bugun", "Dun")
ggplot(seviyeler, aes(x=Bugun, y=Dun))+
  geom_point(shape=1)+geom_smooth(method=lm,color="red",se=TRUE)+
  annotate("text", x=2,y=4,label= cor(seviyeler$Bugun,seviyeler$Dun))

## 7- Artis-Azalis biçiminde inceleyelim
dolar_yon <- as.factor(na.omit(diff(dolar_seviye)>=0))
runs.test(dolar_yon,alternative = "two.sided") # Rassallik sinamasi yapalim

## 8- Rassallik sinamasini simülasyon yoluyla yapalim
runs_sim <- function(x) {y<-rbinom(dim(x)[1],1,0.5) 
r<-sum(sign(y))+1} # sinama istatistigi
runs_stat <- replicate(10000,runs_sim(na.omit(diff(dolar_seviye))))
hist(runs_stat,col="yellow")
abline(v=quantile(runs_stat,probs=c(0.025,0.5,0.975)),col="black",lwd=1,lty=2)
abline(v=sum(sign(na.omit(diff(dolar_seviye)>=0)))+1,col="red",lwd=2,lty=1)

## 9- Rassallik sinamasini bootstrap yoluyla yapalim
runs_func<-function(x,d){r<-sum(sign(x[d]))+1}
runs_boot<-boot(na.omit(diff(dolar_seviye)>=0),runs_func,1000)
boot.ci(runs_boot, conf=0.95,type = c("norm","perc"))
plot(runs_boot)

## 10- Rassallik sinamasini GLM yoluyla yapalim
n<-length(dolar_yon)
glmlfit<-glm(dolar_yon[2:n]~dolar_yon[1:n-1],family=binomial)
#glmfit<-glm(dolar_yon~seq_along(dolar_yon),family=binomial)
summary(glmlfit)

## 11- Rassal yürüyüs olabilir mi?

# Önce bir rassal yürüyüs serisi simüle edelim.
rassal_yuruyus <- as.xts(x=cumsum(rnorm(dim(dolar_seviye)[1],0,sd(na.omit(diff(dolar_seviye))))),order.by=dates)
rassal_veri <- na.omit(merge(rassal_yuruyus,lag(rassal_yuruyus,k=1))) 
colnames(rassal_veri) = c("Bugun", "Dun")
ggplot(rassal_veri, aes(x=Bugun, y=Dun))+geom_point(shape=1)+geom_smooth(method=lm,color="red",se=TRUE)+
  annotate("text", x=quantile(rassal_yuruyus,0.05),y=quantile(rassal_yuruyus,0.95),label= cor(rassal_veri$Bugun,rassal_veri$Dun))

# Daha sonra yapay bir degisim serisi simule edip farazi bir kur serisi olusturalim:
change_sim <- rtnorm(dim(dolar_seviye)[1],lower=min(na.omit(diff(coredata(dolar_seviye)))),upper=max(na.omit(diff(coredata(dolar_seviye)))),
                     mean=mean(na.omit(diff(coredata(dolar_seviye)))),sd=sd(na.omit(diff(coredata(dolar_seviye)))))
change_sim[1]<-dolar_seviye[1]
dolar_sim <- as.xts(x=cumsum(change_sim),order.by=dates)
plot(dolar_sim)

## 12- Duraganligi saglamak için getiriler üzerinde çalisalim
dolar_getiri <- na.omit(diff(log(dolar_seviye))*100)
names(dolar_getiri) <- "Gunluk_Getiri"
head(dolar_getiri)

## 13- Duragan olup olmadigini nasil anlayacagiz?

# Gecikmeler arasindaki (kismi) korelasyonlara bakabiliriz
par(mfrow=c(1,2))
Acf(dolar_getiri,lag.max=36,main="Autocorrelation")
Pacf(dolar_getiri,lag.max=36,main="Partial Autocorrelation")

## 14- Birim kök sinamasi yapabiliriz

# Yapisal kirilmalara ve/veya uç gözlemlere dikkat!
adf.test(dolar_getiri, alternative = "stationary") #sifir hipotezi: birim kök vardir (sabit terim ve egilim dahil)
kpss.test(dolar_getiri,null="Trend") #sifir hipotezi: birim kök yoktur (sabit terim ve egilim dahil)

## 15- Getiriler arasindaki ardisik iliskilere bakalim
getiriler <- na.omit(merge(dolar_getiri,lag(dolar_getiri,k=1)))
colnames(getiriler) = c("Bugun", "Dun")
ggplot(getiriler, aes(x=Bugun, y=Dun))+geom_point(shape=1)+geom_smooth(method=lm,color="red",se=TRUE)

## 16- Getirilerin dagilimini inceleyelim
dagilim<-ggplot(dolar_getiri, aes(dolar_getiri$Gunluk_Getiri)) + 
  geom_histogram(aes(y=..density..),
                 bins=100,col="white",fill="blue",alpha=0.1) +
  xlim(c(-4,4)) + 
  ggtitle("Getirilerin Siklik Çizimi") + 
  labs(x="Günlük Getiriler", y="Yogunluk")

dagilim

## Uygun teorik dagilimi bulmaya çalisalim

## 17- Normal dagilim
normal <- fitdistr(dolar_getiri,"normal")
dagilim <- dagilim + stat_function(fun=function(x) dnorm(x,mean = normal$estimate[1], sd = normal$estimate[2]), aes(colour="Normal"))
dagilim

## 18- Student dagilimi
tdist <- fitdistr(dolar_getiri,"t")
dagilim <- dagilim + stat_function(fun=function(x) dt((x-tdist$estimate[1])/tdist$estimate[2],df= tdist$estimate[3])/tdist$estimate[2],aes(colour="Student"))
dagilim

## 19- Kernel dagilimi
kernel<- geom_density(aes(colour = "Kernel"))
dagilim <- dagilim + kernel
dagilim

## 20- Tek açiklayicili bir regresyon modeli kuralim
ols_model<-lm(dolar_getiri~lag(dolar_getiri,1))
# ar_model<-arma(dolar_getiri,order = c(1,0))
summary(ols_model)

## 21- Modelin hata terimlerine bakalim
par(mfrow=c(2,1))
Acf(residuals(ols_model)^2)
Pacf(residuals(ols_model)^2)
par(mfrow=c(1,1))

## 22- Peki varyans sabit mi?
var<-replicate(10000,var(sample(dolar_getiri, 250, replace = FALSE))) # örnekleme yoluyla
var_sim<-replicate(10000,var(sample(rnorm(dim(dolar_getiri)[1],0,1), 250, replace = FALSE))) # sabit olsaydi
par(mfrow=c(2,1))
hist(var,col="yellow")
abline(v=var(dolar_getiri),col="red",lwd=2,lty=1)
hist(var_sim,col="yellow")
abline(v=1,col="red",lwd=2,lty=1)
par(mfrow=c(1,1))

## 23- Varyansa hareketli pencere yaklasimiyla bakalim
var_roll<-rollapply(dolar_getiri, width = 250, FUN = var, fill = NA)
autoplot(var_roll) + geom_hline(aes(yintercept=var(dolar_getiri)),col="red")

## 24- Oynaklik için ayrica bir model kuralim
model1<-ugarchspec() # varsayilan model
model2<-ugarchspec(mean.model = list(armaOrder=c(1,0),external.regressors=NULL), 
                   variance.model=list(model="gjrGARCH",garchOrder=c(1,1),external.regressors=NULL),
                   distribution.model="std") # uygun model
garch_tahmin<-ugarchfit(spec=model2,data=dolar_getiri) 
#infocriteria(garch_tahmin)
show(garch_tahmin) # parametre tahminleri

## 25- GARCH tahmini için parametrik görsel çiktilar
par(mfrow=c(1,3))
plot(garch_tahmin,which=3)
plot(garch_tahmin,which=2)
plot(garch_tahmin,which=12)
par(mfrow=c(1,1))

## 26- Yil sonuna kadarki getiri tahminlerini simüle edelim
dates_ongoru<-seq.Date(from=last(dates)+1,to=as.Date("2018-12-31"),by="day")
dates_ongoru<-dates_ongoru[which(weekdays(dates_ongoru) %in% c('Monday','Tuesday', 'Wednesday', 'Thursday', 'Friday'))]
garch_sim<-ugarchsim(fit=garch_tahmin,n.sim=length(dates_ongoru),m.sim=1000,startMethod = "sample")
par(mfrow=c(1,2))
plot(garch_sim,which=1)
plot(garch_sim,which=2)
par(mfrow=c(1,1))

## 27- Olasi patikalar
getiri_sim<-garch_sim@simulation$seriesSim
seviye_sim<-rbind(log(rep(last(coredata(dolar_seviye)),dim(garch_sim@simulation$seriesSim)[2])),getiri_sim/100)
seviye_sim<-exp(apply(seviye_sim,2,cumsum))
seviye_gercek<-matrix(coredata(dolar_seviye),nrow=dim(dolar_seviye),ncol=dim(garch_sim@simulation$seriesSim)[2])
seviye_ongoru<-rbind(seviye_gercek,seviye_sim[2:dim(seviye_sim)[1],])
dates_yeni<-c(dates,dates_ongoru)
seviye_ongoru <- as.xts(x=seviye_ongoru, order.by=dates_yeni)
plot(window(seviye_ongoru[,1:100],start="2015-1-1"))

## 28- Yil sonunda kurun alabilecegi degerler
yilsonu<-last(seviye_ongoru)
hist(coredata(yilsonu),xlim=c(2,8),col="red",breaks=100)
summary(coredata(yilsonu)[1,])