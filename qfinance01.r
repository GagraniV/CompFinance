options(digits=4, width=70)
library(PerformanceAnalytics)
library(zoo)
library(tseries)
library(plyr)
library(mvtnorm)

# get the adjusted closing prices from Yahoo for Vanguard Long-Term Bond Index Inv (VBLTX)
VBLTX_prices = get.hist.quote(instrument="vbltx", start="1994-02-01",
                              end="2015-04-30", quote="AdjClose",
                              provider="yahoo", origin="1970-01-01",
                              compression="m", retclass="zoo")
index(VBLTX_prices) = as.yearmon(index(VBLTX_prices))
#write csv file from zoo object
write.zoo(VBLTX_prices, file = "VBLTX_prices", sep =",") 
class(VBLTX_prices)
colnames(VBLTX_prices)
start(VBLTX_prices)
end(VBLTX_prices)

WFC_prices = get.hist.quote(instrument="wfc", start="1994-02-01",
                            end="2015-04-30", quote="AdjClose",
                            provider="yahoo", origin="1970-01-01",
                            compression="m", retclass="zoo")
index(WFC_prices) = as.yearmon(index(WFC_prices))
#write csv file from zoo object
write.zoo(WFC_prices, file = "WFC_prices",sep =",")  

AAPL_prices = get.hist.quote(instrument="AAPL", start="1994-02-01",
                             end="2015-04-30", quote="AdjClose",
                             provider="yahoo", origin="1970-01-01",
                             compression="m", retclass="zoo")
index(AAPL_prices) = as.yearmon(index(AAPL_prices))
#write csv file from zoo object
write.zoo(AAPL_prices, file = "AAPL_prices",sep =",") 

SP500_prices = get.hist.quote(instrument="^GSPC", start="1994-02-01",
                              end="2015-04-30", quote="AdjClose",
                              provider="yahoo", origin="1970-01-01",
                              compression="m", retclass="zoo")
index(SP500_prices) = as.yearmon(index(SP500_prices))
#write csv file from zoo object
write.zoo(SP500_prices, file = "SP500_prices",sep =",")

# read dowloaded data
SP500_prices <- read.csv("SP500_prices")
AAPL_prices <- read.csv("AAPL_prices")
VBLTX_prices <- read.csv("VBLTX_prices")
WFC_prices <- read.csv("WFC_prices")

wfc <- read.csv("~/Finance/Coursera/qfinance/wfc.csv")
class(wfc)
str(wfc)
head(wfc)
tail(wfc)
colnames(wfc)
rownames(wfc)
#with Dates as rownames, we can subset directly on the dates
rownames(wfc) = wfc$Date
class(wfc$Date)
class(wfc$Adj.Close)

#extract the first 5 rows of the price data. 
wfc[1:5, 2, drop=FALSE]
# find indices associated with the dates 
which(wfc == "3/1/1995")
# extract prices between
wfc[13:25,]

## plot the data


# note: the default plot is a "points" plot
plot(wfc$Adj.Close)

plot(wfc$Adj.Close, type="l", col="blue", 
     lwd=2, ylab="Adjusted close",
     main="Monthly closing price of wfc")
# now add a legend
legend(x="topleft", legend="wfc", 
       lty=1, lwd=2, col="blue")

#
# compute returns
## create a new data.frame containing the price data with the dates as the row names
wfcPrices.df = wfc[, "Adj.Close", drop=FALSE]
rownames(wfcPrices.df) = wfc.df$Date
head(wfcPrices.df)

# simple 1-month returns
n = nrow(wfcPrices.df)
wfc.ret.df = (wfcPrices.df[2:n,1,drop=FALSE] - wfcPrices.df[1:(n-1),1,drop=FALSE])/wfcPrices.df[1:(n-1),1,drop=FALSE]
# notice that wfc.ret is not a data.frame object
class(wfc.ret)
# now add dates as names to the vector. 
names(wfc.ret) = rownames(wfcPrices.df)[2:n]
head(wfc.ret)

# continuously compounded 1-month returns
wfc.ccret = log(1 + wfc.ret)
# alternatively
wfc.ccret = log(wfcPrices.df[2:n,1]) - log(wfcPrices.df[1:(n-1),1])
names(wfc.ccret) = rownames(wfcPrices.df)[2:n]
head(wfc.ccret)

# compare the simple and cc returns
head(cbind(wfc.ret, wfc.ccret))

# plot the simple and cc returns in separate graphs
# split screen into 2 rows and 1 column
# to solve the error message ""Error in plot.new() : figure margins too large".
par("mar")
par(mar=c(1,1,1,1))

par(mfrow=c(2,1))
# plot simple returns first
plot(wfc.ret, type="l", col="blue", lwd=2, ylab="Return",
     main="Monthly Simple Returns on wfc")

abline(h=0)     
# next plot the cc returns
plot(wfc.ccret, type="l", col="blue", lwd=2, ylab="Return",
     main="Monthly Continuously Compounded Returns on wfc")
abline(h=0)     
# reset the screen to 1 row and 1 column
par(mfrow=c(1,1))     

# plot the returns on the same graph
plot(wfc.ret, type="l", col="blue", lwd=2, ylab="Return",
     main="Monthly Returns on wfc")
# add horizontal line at zero
abline(h=0)     
# add the cc returns
lines(wfc.ccret, col="red", lwd=2)
# add a legend
legend(x="bottomright", legend=c("Simple", "CC"), 
       lty=1, lwd=2, col=c("blue","red"))
#
# calculate growth of $1 invested in wfc
#

# compute gross returns
wfc.gret = 1 + wfc.ret
# compute future values
wfc.fv = cumprod(wfc.gret)
plot(wfc.fv, type="l", col="blue", lwd=2, ylab="Dollars", 
     main="FV of $1 invested in wfc")
Enter file contents here
