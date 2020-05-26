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

	  def my_all?
		 return to_enum unless block_given?
		   self.my_each do |i|
		   	 return false if yield(i) == false
		   end
		 true
	  end

	  def my_any?
		 return to_enum unless block_given?
		   self.my_each do |i|
		   	 return true if yield i
		   end
		  false
	  end

	  def my_none?
		return to_enum unless block_given?
		  self.my_each do |i|
			return false if yield(i) == true
		   end
		true
	  end



end