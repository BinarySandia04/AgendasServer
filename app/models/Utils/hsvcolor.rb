class Utils::Hsvcolor
  def initialize(h, s, v)
    @hue = h
    @saturation = s
    @value = v
  end

  def to_rgb
    c = @value * @saturation
    h = @hue / 60
    x = c * (1 - (h % 2 - 1).abs).to_f

    r, g, b = 0.0
    if 0 <= h && h <= 1
      r = c
      g = x
      b = 0
    elsif 1 < h && h <= 2
      r = x
      g = c
      b = 0
    elsif 2 < h && h <= 3
      r = 0
      g = c
      b = x
    elsif 3 < h && h <= 4
      r = 0
      g = x
      b = c
    elsif 4 < h && h <= 5
      r = x
      g = 0
      b = c
    elsif 5 < h && h <= 6
      r = c
      g = 0
      b = x
    else
      r = 0
      g = 0
      b = 0
    end
    m = @value - c
    r += m
    g += m
    b += m

    rr = r * 255.0
    gg = g * 255.0
    bb = b * 255.0

    puts rr, gg, bb
    return Utils::Color.new(rr.to_i, gg.to_i, bb.to_i)
  end
end
