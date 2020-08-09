class Color
  def initialize(r, g, b)
    @red = r
    @green = g
    @blue = b
  end

  def toInt
    (toBinary(@red, 8) + toBinary(@green, 8) + toBinary(@blue, 8)).to_i(2)
  end

  def toBinary(i, just)
    i.to_s(2).rjust(just, '0')
  end

  def self.fromInt(i)
    r = toBinary(i, 24)
    colors = r.scan(/.{8}/)
    return Color.new(colors[0], colors[1], colors[2])
  end

  def self.randomBright
    hsv = HSVColor.new(rand(360), 1, 1)
    return hsv.to_rgb
  end
end

