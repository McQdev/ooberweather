command: "oober-weather.widget/get_weather.sh"

refreshFrequency: 5000

style: """
  border-radius: 3px 3px 3px 3px
  border: 1px solid rgba(#fff, 0.5)

  bottom: 670px
  left: 65px
  color: #fff
  font-family: -apple-system, Helvetica Neue
  z-index:3

  table
    border-collapse: collapse
    table-layout: fixed

    &:after
      content: 'WEATHER'
      position: absolute
      left: 0
      top: -18px
      font-size: 11px

  td
    font-size: 14px
    font-weight: 300
    width: 120px
    max-width: 120px
    overflow: hidden

  .wrapper
    padding: 4px 6px 4px 6px
    position: relative

  .col1
    background: rgba(#fff, 0.2)
    border-right: 1px solid rgba(#fff, 0.3)

  .col2
    background: rgba(#fff, 0.1)
    border-right: 1px solid rgba(#fff, 0.3)

  p
    padding: 0
    margin: 0
    font-size: 10px
    font-weight: normal
    max-width: 100%
    color: rgb(170,170,170)
    text-overflow: ellipsis

  .extra
    position: absolute
    top: 2px
    right: 2px
    font-size: 10px
    color: rgb(170,170,170)
    font-weight: normal

"""


render: ->
  """
  <table>
    <tr>
      <td class='col1'></td>
      <td class='col2'></td>
      <td class='col3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  data = output.split('\n')
  table     = $(domEl).find('table')

  renderData = (stat, name, more) ->
    "<div class='wrapper'>" +
      "#{stat}<p>#{name}</p>" +
      "<div class='extra'>#{more}</div>" +
    "</div>"

  for datum, i in data
    args = datum.split(',')
    table.find(".col#{i+1}").html renderData(args...)
