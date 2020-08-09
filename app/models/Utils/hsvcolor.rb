class HSVColor
  def initialize(h, s, v)
    @hue = h
    @saturation = s
    @value = v
  end

  def to_rgb
    c = @value * @saturation
    h = @hue / 60
    x = c * (1 - h % 2 - 1).abs
    r, g, b = 0
    if 0 <= h <= 1
      r = c
      g = x
      b = 0
    elsif 1 < h <= 2
      r = x
      g = c
      b = 0
    elsif 2 < h <= 3
      r = 0
      g = c
      b = x
    elsif 3 < h <= 4
      r = 0
      g = x
      b = c
    elsif 4 < h <= 5
      r = x
      g = 0
      b = c
    elsif 5 < h <= 6
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
    return Color.new(r, g, b)
  end
end
