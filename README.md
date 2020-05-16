# jcorona
Notebook on Corona Outbreak Analysis

#= working (notebook) directory: ~/znb/corona/nb

We start out by getting the data running debian/linux bash shell:                                                              
cd ~/znb/corona/
$ clone https://github.com/bumbeishvili/covid19-daily-data                                                                     

# For later updating:
$ cd ~/znb/corona/covid19-daily-data
$ git pull origin

# These are the files we get:                                                                                                 
$ ls ~/znb/corona/covid19-daily-data                                                                                                        
misc  README.md  time_series_19-covid-Confirmed.csv  time_series_19-covid-Deaths.csv  time_series_19-covid-Recovered.csv       

# Returning to working (notebook) directory
$ cd ~/znb/corona/nb
Now we can look into the time series of confirmed cases, running Julia:

Look into corona.ipynb

=#