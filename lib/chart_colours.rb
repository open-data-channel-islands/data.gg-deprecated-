class ChartColours
    COLOURS = [
        [235,140,45,0.5],
        [51,184,224,0.5],
        [51,222,111,0.5],
        [222,51,111,0.5],
        [232, 219, 71, 0.5],
        [74, 255, 90, 0.5],
        [127, 60, 255, 0.5],
        [232, 89, 151, 0.5],
        [65, 255, 216, 0.5],
        [35, 45, 41, 0.5],
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