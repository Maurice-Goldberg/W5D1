class MaxIntSet

  attr_reader :store
  
  def initialize(max)
    @max = max
    @store = Array.new(@max, false)
  end

  def insert(num)
    if num >= @max || num < 0
      raise "Out of bounds"
    else
      @store[num] = true
    end
  end

  def remove(num)
    if num >= @max || num < 0
      raise "Out of bounds"
    else
      @store[num] = false
    end
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)

  end

  def validate!(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num % num_buckets].push(num)
  end

  def remove(num)
    self[num % num_buckets].delete(num)
  end

  def include?(num)
    self[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      self[num % num_buckets] << num
      @count += 1
      resize! if count > @store.size
    end
  end

  def remove(num)
    if self.include?(num)
      self[num % num_buckets].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num % num_buckets].include?(num)
  end

  private

  def [](num)
    @store[num]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(num_buckets*2) { Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        new_array[num % new_array.length] << num
      end
    end
    @store = new_array
  end


end
