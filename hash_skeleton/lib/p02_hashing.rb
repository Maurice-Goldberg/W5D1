class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    val = 0
    self.each_with_index do |el, i|
      val += (el ^ i).hash
    end
    val
  end
end

class String
  def hash
    val = 0
    self.each_char.with_index do |el, i|
      val += (el.ord ^ i)
    end
    val
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    val = 0
    self.each do |key, value|
      val += (key.object_id ^ value.ord)
    end
    val
  end
end
