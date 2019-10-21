require 'byebug'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    first == @tail && last == @head
  end

  def get(key)
    self.each do |node|
      return node.val if key == node.key
    end
    nil
  end

  def include?(key)
    result = false
    self.each do |node|
      result = true if key == node.key
    end
    result
  end

  def append(key, val)
    node = Node.new(key, val)
    last.next = node
    node.prev = last
    node.next = @tail
    @tail.prev = node
  end

  def update(key, val)
    if self.include?(key)
      self.each do |node|
        node.val = val if node.key == key
      end
    end
  end

  def remove(key)
    if self.include?(key)
      self.each do |node|
        if node.key == key
          node.next.prev = node.prev
          node.prev.next = node.next
          return node.val
        end
      end
    end
  end

  def each
    cursor = @head.next
    until cursor == @tail
      yield(cursor)
      cursor = cursor.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
