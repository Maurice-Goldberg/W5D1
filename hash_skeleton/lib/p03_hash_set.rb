class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    hash_key = key.hash
    unless self.include?(hash_key)
      self[hash_key%num_buckets] << hash_key
      @count += 1
      resize! if count > @store.length
    end
  end

  def include?(key)
    hash_key = key.hash
    self[hash_key%num_buckets].include?(hash_key)
  end

  def remove(key)
    hash_key = key.hash
    if self[hash_key%num_buckets].include?(hash_key)
      self[hash_key%num_buckets].delete(hash_key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
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
