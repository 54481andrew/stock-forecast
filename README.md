## General

This repository contains code for an R Shiny App that downloads and forecasts stock price data. To use the application, specify a stock symbol and date range. Clicking the "Update Plot" button downloads a timeseries dataset with that stock's prices from January 1st, 2017 to the current date. The stock data is converted from daily data into monthly averaged data, then forecasted forward to the end-date selected by the user. Forecasts are built using an exponential triple smoothing algorithm with parameters selected via AICc. 80\% and 95\% prediction intervals, along with the forecast's point predictions, are plotted in the application.  

