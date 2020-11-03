command: "/usr/local/bin/convert \
'https://forecast.weather.gov/meteograms/Plotter.php?lat=40.9015&lon=-73.7766&\
wfo=OKX&zcode=NYZ071&gset=18&gdiff=3&unit=0&tinfo=CY6&ahour=0&\
pcmd=10001010110000000000000000000000000000000000000000000000000&\
lg=en&indu=1!1!1!&dd=&bw=1&hrspan=24&pqpfhr=6&psnwhr=6' \
-negate -fuzz 6% -fill '#000' -opaque '#262626' \
-transparent black -shave 1x1 \
./forecast.widget/Pics/forecast.gif 2>/dev/null; \
echo ./forecast.widget/Pics/forecast.gif"

#command: "/usr/local/bin/convert \
#'https://forecast.weather.gov/meteograms/Plotter.php?lat=45.459&lon=-98.4869&\
#wfo=ABR&zcode=SDZ006&gset=18&gdiff=3&unit=0&tinfo=CY6&ahour=0&\
#pcmd=10001010110000000000000000000000000000000000000000000000000&\
#lg=en&indu=1!1!1!&dd=&bw=1&hrspan=24&pqpfhr=6&psnwhr=6' \
#-negate -fuzz 6% -fill '#000' -opaque '#262626' \
#-transparent black -shave 1x1 \
#./forecast.widget/Pics/forecast.gif 2>/dev/null; \
#echo ./forecast.widget/Pics/forecast.gif"

refreshFrequency: 300000 # 5 Minutes

render: (output)-> """
<img src="#{output}" style="width:366px">
""" #                             ^ Change size here.

style: """
	position: absolute
	left: 65px
	top: 375px
	z-index: -1
	border-radius: 3px
	border solid 1px rgba(#fff, 0.5)
	padding: 1px 1px 1px 1px
	opacity: .8

""" #    ^ Change placement here.
