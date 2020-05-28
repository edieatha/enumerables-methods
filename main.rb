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
    result = []
    my_each do |item|
      result << item if block.call(item) == true
    end
    result
  end

  def my_all?(*arg)
    case result = true
    when !arg[0].nil?
      my_each { |i| result = false if arg[0] == i }
    when !block_given?
      my_each { |i| result = false if i }
    else
      my_each { |i| result = false if yield(i) }
    end
    result
  end

  def my_any?(*arg)
    case result = false
    when !arg[0].nil?
      my_each { |i| result = true if arg[0] == i }
    when !block_given?
      my_each { |i| result = true if i }
    else
      my_each { |i| result = true if yield(i) }
    end
    result
  end

  def my_none?
    return to_enum unless block_given?

    my_each do |i|
      return false if yield(i) == true
    end
    true
  end

  def my_count(result = nil)
    return result if result
    return length unless block_given?

    my_select { |i| yield i }.length
  end

  def my_map(proc = nil)
    return enum_for(:my_map) unless proc || block_given?

    enum = to_enum
    result = []
    my_each do
      result << !proc.nil? ? proc.call(enum.next) : yield(enum.next)
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
