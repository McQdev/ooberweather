# Use this command for white geography lines #

command: "/usr/local/bin/convert \
'https://radblast.wunderground.com/cgi-bin/radar/WUNIDS_composite?\
centerlat=40.9115&\
centerlon=-73.7824&\
radius=300&\
reproj.automerc=1&width=2000&height=2000&newmaps=1&type=n' \
-fuzz 5% -fill white -opaque black -transparent '#292f75' \
./NYradar.widget/Pics/map.png; \
/usr/local/bin/convert \
'https://radblast.wunderground.com/cgi-bin/radar/WUNIDS_composite?\
centerlat=40.9115&\
centerlon=-73.7824&\
radius=300&\
noclutter=1&\
smooth=0&\
reproj.automerc=1&\
width=750&\
height=750&\
num=15&\
delay=20' \
./NYradar.widget/Pics/radar.gif 2>/dev/null; \
echo ./NYradar.widget/Pics/radar.gif"

# Use this command for black geography lines #
###
command: "/usr/local/bin/convert \
'https://radblast.wunderground.com/cgi-bin/radar/WUNIDS_composite?\
centerlat=40.9115&\
centerlon=-73.7824&\
radius=300&\
reproj.automerc=0&width=1500&height=1500&newmaps=1&type=nCr' \
-fuzz 5% -fill black -transparent '#292f75' \
./NYradar.widget/Pics/map.png; \
/usr/local/bin/convert \
'https://radblast.wunderground.com/cgi-bin/radar/WUNIDS_composite?\
centerlat=40.9115&\
centerlon=-73.7824&\
radius=300&\
noclutter=1&\
smooth=0&\
reproj.automerc=0&\
width=750&\
height=750&\
num=15&\
delay=20' \
./NYradar.widget/Pics/radar.gif 2>/dev/null; \
echo ./NYradar.widget/Pics/radar.gif"
###
refreshFrequency: 300000 # 5 Minutes

render: (output)-> """
<div id="container">
	<div id="wrapper">
	<div id="radar">
		<img src="./NYradar.widget/Pics/radar.gif" style="width: 700px">
	</div>
	<div id="map">
		<img src="./NYradar.widget/Pics/map.png" style="width: 700px">
	</div>
	</div>
	<div id="after">RADAR</div>
</div>
"""

style: """

#container {
		position: relative;

/* USE THIS TO ADUJST SIZE AND POSITION! */
/*---------------------------------------*/
		left: 460px;
		top: 317px;
		width: 595px;
		height: 534px;
/*---------------------------------------*/
		border-radius: 3px;
		border solid 1px rgba(#fff, 0.5);
		padding: 1px;
}

#wrapper {
	  position: absolute;
		width: 99.7%;
		height: 99.5%;
		overflow: hidden;
}

#radar {
		position: absolute;
		top: 1;
		left: 1;
}
#map {
		position: absolute;
		top: 1;
	  left: 1;
		z-index: 0;
}

#after {
      position: absolute;
      left: 0px;
      top: -18px;
      font-size: 11px;
			color: #fff;
			font-family: -apple-system, Helvetica Neue
}
"""
