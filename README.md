## General

&nbsp;

This repository contains code for an R Shiny App that downloads and
forecasts stock price data. To use the application, specify a stock
symbol and date range. Clicking the "Update Plot" button downloads a
timeseries dataset with that stock's prices from January 1st, 2017 to
the current date.

&nbsp;

## About the forecast

&nbsp;

The stock data is converted from daily data into
monthly averaged data, then forecasted forward to the end-date
selected by the user. Forecasts are built using an exponential triple
smoothing algorithm with parameters selected via AICc. 80\% and 95\%
prediction intervals, along with the forecast's point predictions, are
plotted in the application.

&nbsp;


## See it in action

&nbsp;


The forecast is embedded at the bottom of [my webpage](https://54481andrew.github.io/)
and is also available as a [standalone app](https://54481andrew.shinyapps.io/stock-forecast-master/?_ga=2.75585557.1657573091.1628519881-2013378022.1628214290).

&nbsp;
&nbsp;
&nbsp;
&nbsp;
