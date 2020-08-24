class Utils::Color
  attr_accessor :red, :green, :blue

  def initialize(r, g, b)
    self.red = r
    self.green = g
    self.blue = b
  end

  def toInt
    (toBinary(self.red, 8) + toBinary(self.green, 8) + toBinary(self.blue, 8)).to_i(2)
  end

  def toHex
    self.red.to_s(16).rjust(2, '0') + self.green.to_s(16).rjust(2, '0') + self.blue.to_s(16).rjust(2, '0')
  end

  def isBright
    if (self.red*0.299 + self.green*0.587 + self.blue*0.114) > 150
      return true
    else
      return false
    end
  end

  def self.fromHex(s)
    s[0] = ''
    colors = s.scan(/.{2}/)
    puts "_--------"
    puts colors
    for i in 0..2
      colors[i] = colors[i].to_s.to_i(16)
    end
    return Utils::Color.new(colors[0], colors[1], colors[2])
  end

  def toBinary(i, just)
    i.to_s(2).rjust(just, '0')
  end

  def self.fromInt(i)
    r = i.to_s(2).rjust(24, '0')
    colors = r.scan(/.{8}/)
    # CONVERTIR A INT?
    for i in 0..2
      colors[i] = colors[i].to_i(2)
    end
    return Utils::Color.new(colors[0], colors[1], colors[2])
  end

  def self.randomBright
    hsv = Utils::Hsvcolor.new(rand(360), 1, 1)
    return hsv.to_rgb
  end
end

