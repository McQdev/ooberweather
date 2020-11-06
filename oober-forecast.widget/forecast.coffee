latitude = '40.9015'
longitude = '-73.7766'
wfo = 'OKX'
zcode = 'NYZ071'

# White Lines
command: "/usr/local/bin/convert \
'https://forecast.weather.gov/meteograms/Plotter.php?lat=#{latitude}&lon=#{longitude}&\
wfo=#{wfo}&zcode=#{zcode}&gset=18&gdiff=3&unit=0&tinfo=CY6&ahour=0&\
pcmd=10001010110000000000000000000000000000000000000000000000000&\
lg=en&indu=1!1!1!&dd=&bw=1&hrspan=24&pqpfhr=6&psnwhr=6' \
-negate -fuzz 6% -fill '#000' -opaque '#262626' \
-transparent black -shave 1x1 \
./oober-forecast.widget/Pics/forecast.gif 2>/dev/null; \
echo ./oober-forecast.widget/Pics/forecast.gif"

### Black Lines
command: "/usr/local/bin/convert \
'https://forecast.weather.gov/meteograms/Plotter.php?lat=#{latitude}&lon=#{longitude}&\
wfo=#{wfo}&zcode=#{zcode}&gset=18&gdiff=3&unit=0&tinfo=CY6&ahour=0&\
pcmd=10001010110000000000000000000000000000000000000000000000000&\
lg=en&indu=1!1!1!&dd=&bw=1&hrspan=24&pqpfhr=6&psnwhr=6' \
-fuzz 20% -fill '#FFF' -opaque '#E5E5E5' \
-transparent white -shave 1x1 \
./oober-forecast.widget/Pics/forecast.gif 2>/dev/null; \
echo ./oober-forecast.widget/Pics/forecast.gif"
###

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
