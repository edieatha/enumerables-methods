module Enumerable
	def my_each
		return to_enum unless block_given?
		n = 0
    while n < self.size
        yield(self[n])
      n += 1
    end
  end

  def my_each_with_index
		return to_enum unless block_given?
		n = 0
    while n < self.size
        yield(self[n], index)
      n += 1
    end
  end

def my_select(&block)
    result =[]
    self.my_each do |item|
      result << item if block.call(item) == true
    end
    result
  end

end