module Enumerable
  # friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']
  # friends.my_each { |friend| puts "Hello, " + friend }
  # my_each
  def my_each
    return to_enum unless block_given?

    n = 0
    while n < size
      yield(self[n])
      n += 1
    end
  end

  # fruits = ["apple", "banana", "strawberry", "pineapple"]
  # fruits.each_with_index { |fruit, index| puts fruit if index.even?
  # my_each_with_index
  def my_each_with_index
    return to_enum unless block_given?

    n = 0
    while n < size
      yield(self[n], index)
      n += 1
    end
  end

  # p [1, 2, 3, 4, 6].my_select{ |i| i.even?}
  # my_select
  def my_select(&block)
    result = []
      self.my_each do |item|
        result << item if block.call(item) == true
      end
    result
  end

  # puts [1, 2, 3, 4].my_all?{ |i| i.even?}
  # puts [1, 2, 3, 4].my_all?{ |i| i < 6}
  # my_all
  def my_all?(*arg)
    case result = true
    when !arg[0].nil?
      my_each { |i| result = false if arg[0] === i }
    when !block_given?
      my_each { |i| result = false if i }
    else
      my_each { |i| result = false if yield(i) }
    end
    result
  end


  # puts [1, 2, 3, 4].my_any?{ |i| i.even?}
  # puts [1, 2, 3, 4].my_any?{ |i| i > 6}
  # my_any
  def my_any?(*arg)
    case result = false
    when !arg[0].nil?
      my_each { |i| result = true if arg[0] === i }
    when !block_given?
      my_each { |i| result = true if i }
    else
      my_each { |i| result = true if yield(i) }
    end
    result
  end

  # puts [1, 2, 3, 4].my_none?{ |i| i.even?}
  # puts [1, 2, 3, 4].my_none?{ |i| i > 6}
  # my_none
  def my_none?
    return to_enum unless block_given?

      self.my_each do |i|
        return false if yield(i) == true
      end
    true
  end

  # [4, 5, 6].my_count => 3
  # [4, 5, 6].my_count(5) => 5
  # [4, 5, 6].my_count { |i| i > 4 } => 2
  # my_count
  def my_count(result = nil)
    return result if result
    return length unless block_given?

    my_select { |i| yield i }.length
  end

  # [1,2,3,4,5].my_map { |i| i * 2 }
  # my_proc = proc{ |i| i*2 }
  # p [1, 2, 3, 4].my_map(&my_proc)
  # my_map
  def my_map(proc=nil)
    return enum_for(:my_map) unless proc || block_given?

    enum = self.to_enum
    result = []
    my_each do
      result << (proc != nil ? proc.call(enum.next) : yield(enum.next))
    end
    result
  end

  # puts [1, 2, 3, 4].my_inject(:*)
  # my_inject
  def my_inject(*arg)
    accumulator = arg[0] if arg[0].is_a?(Integer)

    if arg[0].is_a?(Symbol)
      my_each{ |item| accumulator = accumulator ? accumulator.send(arg[0], item) : item}
      accumulator
      else
      sum = 0
      each do |item|
        sum = yield(sum, item)
    end
    sum
  end

  def multilply_els
    self.my_inject(:*)
  end
end