class ChartColours
  COLOURS = [
[89,45,45,0.6],
[140,94,0,0.6],
[0,255,34,0.6],
[64,64,255,0.6],
[77,0,51,0.6],
[255,34,0,0.6],
[255,242,64,0.6],
[0,255,238,0.6],
[200,191,255,0.6],
[255,64,115,0.6],
[255,200,191,0.6],
[40,51,38,0.6],
[77,117,153,0.6],
[42,38,51,0.6],
[255,140,64,0.6],
[51,102,58,0.6],
[38,69,153,0.6],
[255,0,238,0.6],
  ]

  def self.darken_color(rgba, amount=0.8)
    newRgba = []
    newRgba << (rgba[0].to_i * amount).round
    newRgba << (rgba[1].to_i * amount).round
    newRgba << (rgba[2].to_i * amount).round
    newRgba << rgba[3]
    newRgba
  end

  def self.lighten_color(rgba, amount=0.8)
    newRgba = []
    newRgba << [(rgba[0].to_i + 255 * amount).round, 255].min
    newRgba << [(rgba[1].to_i + 255 * amount).round, 255].min
    newRgba << [(rgba[2].to_i + 255 * amount).round, 255].min
    newRgba << rgba[3]
    newRgba
  end

end