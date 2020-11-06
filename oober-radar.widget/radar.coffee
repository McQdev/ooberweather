# White lines

### black lines
command: "/usr/local/bin/convert \
'https://radblast.wunderground.com/cgi-bin/radar/WUNIDS_composite?\
centerlat=#{latitude}&\
centerlon=#{longitude}&\
radius=300&\
reproj.automerc=0&width=1500&height=1500&newmaps=1&type=nCr' \
-fuzz 5% -fill black -transparent '#292f75' \
./oober-radar.widget/Pics/map.png; \
/usr/local/bin/convert \
'https://radblast.wunderground.com/cgi-bin/radar/WUNIDS_composite?\
centerlat=#{latitude}&\
centerlon=#{longitude}&\
radius=300&\
noclutter=1&\
smooth=0&\
reproj.automerc=0&\
width=750&\
height=750&\
num=15&\
delay=20' \
./oober-radar.widget/Pics/radar.gif 2>/dev/null;""
###

refreshFrequency: 300000 # 5 Minutes

render: (output)-> """
<div id="container">
	<div id="wrapper">
	<div id="radar">
		<img src="./oober-radar.widget/Pics/radar.gif" style="width: 600px">
	</div>
	<div id="map">
		<img src="./oober-radar.widget/Pics/map.png" style="width: 600px">
	</div>
	</div>
	<div id="after">RADAR</div>
</div>
"""
afterRender: (domEl) ->
  geolocation.getCurrentPosition (e) =>
    coords     = e.position.coords
    [lat, lon] = [coords.latitude, coords.longitude]
    @command   = @makeCommand("#{lat}","#{lon}")

makeCommand: (lat,lon) ->
  "/usr/local/bin/convert \
	'https://radblast.wunderground.com/cgi-bin/radar/WUNIDS_composite?\
	centerlat=#{lat}&\
	centerlon=#{lon}&\
	radius=300&\
	reproj.automerc=1&width=2000&height=2000&newmaps=1&type=n' \
	-fuzz 5% -fill white -opaque black -transparent '#292f75' \
	./oober-radar.widget/Pics/map.png; \
	/usr/local/bin/convert \
	'https://radblast.wunderground.com/cgi-bin/radar/WUNIDS_composite?\
	centerlat=#{lat}&\
	centerlon=#{lon}&\
	radius=300&\
	noclutter=1&\
	smooth=0&\
	reproj.automerc=1&\
	width=750&\
	height=750&\
	num=15&\
	delay=20' \
	./oober-radar.widget/Pics/radar.gif 2>/dev/null"

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
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%);
}
#map {
    position: absolute;
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%)
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
