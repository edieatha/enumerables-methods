module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    n = 0
    while n < size
      yield(self[n])
      n += 1
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    n = 0
    while n < size
      yield(self[n], index)
      n += 1
    end
  end

  def my_select(&block)
    return to_enum(:my_select) unless block_given?

    result = []
    my_each do |item|
      result << item if block.call(item) == true
    end
    result
  end

  def my_all?(*args)
    if !args[0].nil?
      my_each { |i| return false unless args[0] === i }
    elsif block_given?
      my_each { |i| return false unless yield(i) }
    else
      my_each { |i| return false unless i }
    end
    true
  end

  def my_any?(*arg)
    if !arg[0].nil?
      my_each { |i| return true if arg[0] === i }
    elsif block_given?
      my_each { |i| return true if yield(i) }
    else
      my_each { |i| return true if i }
    end
    false
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  def my_count(result = nil)
    array = is_a?(Range) ? to_a : self

    return array.length unless block_given? || result

    true_items = []
    if result
      array.my_each { |item| true_items << item if item == result}
    else
      array.my_each{ |item| true_items << item if yield(item) === true}
    end
    true_items.length
  end

  def my_map(proc = nil)
    arr = is_a?(Array) ? self : to_a
    result = []

    if !proc.nil?
      arr.my_each { |item| result << proc.call(item) }
    else
      return to_enum(:my_map) unless block_given?

      arr.my_each { |item| result << yield(item) }
    end
    result
  end

  def my_inject(*arg)
    accumulator = arg[0] if arg[0].is_a?(Integer)

    if arg[0].is_a?(Symbol)
      my_each { |item| accumulator = accumulator ? accumulator.send(arg[0], item) : item }
      accumulator
    else
      sum = 0
      each do |item|
        sum = yield(sum, item)
      end
    end
    sum
  end

  def multilply_els
    my_inject(:*)
  end
end
