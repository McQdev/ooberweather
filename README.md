# ooberweather
A small, hacky suite of weather widgets for Übersicht

# DETAILS
At present, the package contains three widgets:

1. oober-weather : A small, text-based widget that displays current temp, heat index or wind chill, humidity, and windspeed, gusts and direction, scraped from NOAA public data

2. oober-forecast : A medium widget that displays a customizable meteogram image scraped from NOAA public data

3. oober-radar : A large widget that displays a regional NEXRAD Base-level doppler radar image scraped from Weatherunderground

# DEPENDENCIES
All three require Übersicht installed and are only tested on MacOS 10.15. Übersicht can be installed from https://tracesof.net/uebersicht/. 

oober-forecast and oober-radar both require imagemagick, which can be installed via brew, Macports, or from an installer package on https://www.imagemagick.org

# SPECIFYING USER VALUES
I am a terrible programmer so at present, each widget requres you to look up some specific information and manually edit the widget code in-line. Future versions of these will hopefully make that process easier and include less onerous customizations by just specifying variable values at the top, maybe even do the lookup work for you. In the meantime, here's what you need to go find and edit:

oober-weather: You need the 4-letter code for your nearest ASOS weather station. THese can be found on the FAA's website, https://www.faa.gov/air_traffic/weather/asos/ . Replace the letters in each of the 4 URLS for TEMP, FEELTEMP, HUMIDITY, and WIND in the get_weather.sh shell script in the oober-weather folder. 

oober-forecast: You need four pieces of information from your location's NOAA meteogram. These are published on the NOAA's forecast page for your zip code, accessible here https://www.weather.gov. On the right side, there's a thumbnail of a meteogram graph under the heading "Hourly Forecast." Click that, and then find the URL for the metogram image itself. It will look something like this: https://forecast.weather.gov/meteograms/Plotter.php?lat=34.0714&lon=-118.3974&wfo=LOX&zcode=CAZ041... It's the 4 variables after the Plotter.php call: lat, lon, wfo, and zcode. Copy these and replace them in the  forecast.coffee file in the oober-forecast folder. 

oober-radar: You need the latitude and longitude here as well, and you can use the same from the meteogram above. Just replace the values for centerlat and centerlon which appear twice in the commands at the top of the radar.coffee file in the oober-radar widget folder. Or you can find them with any other GPS lookup tool, I don't judge. 

# OTHER CUSTOMIZATION FEATURES

All three widgets are fully stylable via CSS in their respective .coffee files, where fonts, colors, sizes, and locations can all be edited, as well as, you know, whatevber the heck else you want them to do. At present, they're styled to match a number of other popular minimal Übersicht widgets, but they're very hackable. Most people will probably just want to change positions and possibly sizes. 

Beyond that, here are some additional options in each widget: 

oober-weather: Default values are imperial. If you prefer Metric, simply add "metric/" before the station ID in the 4 URLs in the get_weather.sh script.

oober-forecast: There's actually a lot you can do here, by tweaking the meteogram URL within the command. Here's how it breaks down, as far as I've reverse-engineered, since there's no public documentation of this:

lat, lon, wfo, and zcode are all local forecast station location info. 
gset:   ?
gdiff:  ?
unit:   Imperial (0) or Metric (1)
tinfo:  Date legends on the x-axis. Only accurate at "CY6" so leave as-is
ahour:  How many hours ahead of current time to begin metogram. Leave at 0 to begin at current time.
pcmd:   LONG binary number that specifies which data to plot. Each digit is a binary on/of key for that datum. In order, they are:
        1 -  Temperature
        2 -  Dewpoint
        3 -  Heat Index
        4 -  Wind Chill
        5 -  Sustained Wind Speed (with directional barbs)
        6 -  Sky Cover
        7 -  Precipitation Potential
        8 -  Relative Humidity
        9 -  Rain Likelihood
        10 - Thunder Likelihood
        11 - Snow Likelihood
        12 - Freezing Rain Likelihood
        13 - Sleet Likelihood
        14 - Freezing Spray Likelihood
        15 - Fog Likelihood
        16 - Ceiling Height
        17 - Visibility
        18 - Significant Wave Height
        19 - Wave Period
        20 - ?
        21 - Mxing Height
        22 - Haines Index
        23 - Lighting Activity Level
        24 - Transport Wind speed (with directional barbs)
        25 - 20-foor Wind Speed (with directional barbs)
        26 - Ventilation Rate
        27 - 
        
        

