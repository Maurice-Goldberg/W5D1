require_relative 'p04_linked_list'
require "byebug"

class HashMap
  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    result = @store[bucket(key)].include?(key)
    return result
  end

  def set(key, val)
    if include?(key)
      puts "testing whether include returns true"
      @store[bucket(key)].update(key, val)
    else
      @store[bucket(key)].append(key, val)
      @count += 1
      resize! if count > num_buckets
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  def [](key)
    get(key)
  end

  # def []=(key, value)
  #   debugger
  #   if include?(key)
  #     puts "testing whether include returns true"
  #     @store[bucket(key)].update(key, value)
  #   else
  #     @store[bucket(key)].append(key, value)
  #     @count += 1
  #   end
  # end


  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(num_buckets*2) { LinkedList.new }
    @store.each do |list|
      list.each do |node|
        new_array[node.key.hash % new_array.length].append(node.key, node.val)
      end
    end
    @store = new_array
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
