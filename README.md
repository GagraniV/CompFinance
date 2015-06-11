The overall goal of the CompFinace repository is to the use power and flexibility of R programming language in field of computational finance. Analysis is mostly based on a coursera course on computational finance by E.Zivot.

1. Qfinance01.R script reads mothly adjusted closing prices of assests ("wfc","sp500", "aapl","vbltx")from Febuary 1992 to April 2015) and save as .txt file. The goal is to ompute monthly simple and continous compounding returns and  gross returns of a single assest("wfc").

2. Qfinance02.rmd script reads monthly adjusted closing proces of more than one assests ("wfc","sp500", "aapl","vbltx")  from Febuary 1992 to April 2015. The goal is to compute continous compounding monthly returns,simulate constant expected return or CER model, simulate random walk model or RWM, estimate model parameters (i.e., mean, variance,sd, confidence intervals, covariance, and correlation), apply Monte Carlo simulation to compute sampling distribution of statisics,Compute rolling mean and SD values,estimate Quantiles and VaR from CER model,Bootstrapping, hypothesis testing.

Resources: http://faculty.washington.edu/ezivot/econ424/424notes.htm
