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
        pcmd:   93-digit binary number that specifies which data to plot. Each digit is a binary on/of key for that datum. In order, they are:
                1 - Temperature
                1 - Dewpoint
                3 -  Heat Index
                4 -  Wind Chill
                5 -  Sustained Wind Speed and Gusts (with directional barbs)
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
                25 - 20-foot Wind Speed (with directional barbs)
                26 - Ventilation Rate
                27 - Swell Height
                28 - Swell Period
                29 - Swell 2 Height
                30 - Swell 2 Period
                31 - Wind Wave Height
                32 - Dispersion Index
                33 - Pressure
                34 - 15mph Wind Likelihood
                35 - 25mph Wind Likelihood
                36 - 35mph Wind Likelihood
                37 - 45mph Wind Likelihood
                38 - 20mph Gust Likelihood
                39 - 30mph Gust Likelihood
                40 - 40mph Gust Likelihood
                41 - 50mph Gust Likelihood
                42 - 60mph Gust Likelihood
                43 - 6 hour Quantitative Precipitation Forecast (0.10)
                44 - 6 hour Quantitative Precipitation Forecast (0.25)
                45 - 6 hour Quantitative Precipitation Forecast (0.50)
                46 - 6 hour Quantitative Precipitation Forecast (1.00)
                47 - 6 hour Quantitative Precipitation Forecast (2.00)
                48 - 0.1 inch 6 hour Snowfall Likelihood
                49 - 1 inch 6 hour Snowfall Likelihood
                50 - 3 inch 6 hour Snowfall Likelihood
                51 - 6 inch 6 hour Snowfall Likelihood
                52 - 12 inch 6 hour Snowfall Likelihood
                53 - Grassland Fire Danger Index
                54 - Thunder Potential
                55 - Davis Stability Index
                56 - Atmospheric Dispersion Index
                57 - Low Visibility Occurrence Risk Index
                58 - Turner Stability Index
                59 - Red Flag Threat Index
                60 through 93 - ? (honestly I checked the first 3 or 4 and the last 3 or 4 and they were all invalid images)

                It appears safe to leave off all trailing zeroes after the last 1 desired key, so don't feel like you have to use them all. 
                The default set in this package includes Temperature, Windspeed, Gusts, Precipitation Potential, Rain Likelihood, and Thunder Likelihood.

        lg:     Languge. Unknown codebook, but "en" is english and "sp" works for spanish. 
        indu:   Windspeed units for surface winds, transport winds, and 20-foot winds. 0 is mph, 1 is knots, keys are separated by a bang (!).
        dd:     Dashes and Dots. 0 plots solid lines with small dots, 1 plots solid/dashed lines and differentiated, large dots.
        bw:     Color (0) or Black & White (1)
        hrspan: Hours to plot (up to 48)
        pqpfhr: ?
        psnwhr: ?

By default, the image processing takes a black and white version, negates it, and strips away any gridlines and shading. But this is togglable by adjusting the convert command. Here's how it currently works:

        negate:        Creates a white-on-black version of the source image
        fuzz:          Creates a margin for color replacement (change this to 5 if you want gridlines)
        fill:          Defines the replacement color for the next value
        opaque:        Chooses the opaque color to replace, in this case #262626. 
        transparent:   Makes the background color (in this case black) transparent
        shave:         Remove the outside border by contracting the image by 1 pixel on all sides. 
        
oober-radar: The URL in the command for both the map and the radar data itself has a number of adjustable features:
        
        radius:                 Distance from the map center (miles)
        noclutter:              Reduce radar noise (1) or show raw feed (0)
        smooth:                 Smooth radar data (1) or show raw shapes (0)
        reproj.automerc:        Change map projection. Leaving this variable out altoghether compresses the image vertically.
        width and height:       Image resolution. It seems to theoretically render at any resolution so be careful. If you have a 
                                retina display it looks very good at double the resolution determined for the widget in CSS. 
        num:                    Number of radar frames to render for animation (up to 15)
        delay:                  The amount of time between frames (more time = slower)
        newmaps:                Remnder the geography lines or not. Keep on for the map command, off for the radar.
        type:                   Radar product. Default is N0R, base reflectivity 0.50º. Options are:
                                N0R: Base Reflectivity 0.50º 124NMI Range
                                N1R: Base Reflectivity 1.45º 124NMI Range
                                N2R: Base Reflectivity 2.40º 124NMI Range
                                N3R: Base Reflectivity 3.35º 124NMI Range
                                N0Z: Base Reflectivity 0.50º 248NMI Range
                                N0V: Base Radial Velocity 0.50º 124NMI Range
                                N0S: Storm Relative Mean Radial Velocity 0.50º 124NMI Range
                                N1S: Storm Relative Mean Radial Velocity 1.45º 124NMI Range
                                N2S: Storm Relative Mean Radial Velocity 2.40º 124NMI Range
                                N3S: Storm Relative Mean Radial Velocity 3.35º 124NMI Range
                                NTP: Storm Total Surface Rainfall Accumulation 124NMI Range
                                N1P: 1 Hour Running Surface Rainfall Accumulation 124NMI Range
                                n:   No radar product. Exploited to produce blank map. 
        severe:                 Show severe weather regions (1) or not (0)
        rainsnow:               Differentiate between rain and snow (1) or not (0)
        showstorms:             Number of storms to show trajectories for (up to 99)
        
Further, there are two options for geography: black lines or white lines. Simply adjust the comments (###) to select the preferred option. Also, the colors of the radar are the default NEXRAD colors, but they can be inverted for aesthetics by including "-negate" after the radar URL (it looks *rad*).

# FINAL WORDS
Everything is very, very hacky because I'm a total amateur. Don't hate me, just tweak, polish, and change as needed. 
        
        

