module Enumerable

  def my_each
    n = 0
    while n < self.length do 
      yield(self[n]) if self.is_a?(Array)
      yield(keys[n], self[keys[n]]) if self.is_a?(Hash)
      yield(self[n]) if self.is_a?(Range)
      n += 1
    end
    self
  end

  def my_each_with_index
    n = 0
    while n < self.length do
      yield(self[n], self.index(self[n])) if self.is_a?(Array)
      yield(keys[n], self[keys[n]]) if self.is_a?(Hash)
      yield(self[n]) if self.is_a?(Range)
      n += 1
    end
    self
  end

  def my_select
    if self.is_a?(Array)
      result = []
      self.my_each{|element| result << element if yield(element)}

    elsif self.is_a?(Hash)
      result = {}
      self.my_each{|e_key, e_value| result[e_key] = e_value if yield(e_key, e_value)}
    end
    p result
  end

  def my_all?(block = false)
    a = true
    self.my_each do |element|
      if(block)
        c = element.is_a?(block)
      else
        c = yield(element)
      end
      a = a && c
    end
    p a
  end

  def my_any?(block = false)
    a = false
    self.my_each do |element|
      if(block)
        c = element.is_a?(block)
      else
        c = yield(element)
      end
      a = a || c
    end
    p a
  end

  def my_none?(block = false)
    a = false
    self.my_each do |element|
      if(block)
        c = element.is_a?(block)
      else
        c = yield(element)
      end
      a = a || c
    end
    p !a
  end

  def my_count(block = false)
    result = []
    # a = false
    self.my_each do |element|
      if(block && element == block)
        result << element
      elsif (block_given? && yield(element))
        result << element
      elsif (!block && !block_given?)
        result << element
      end
    end
    a = result.length
    p a
  end

end

array = [1.6, 4.6, 56, 6, 7, 23, 5, 7, 3, 67, 8, 400]
hash = {"hey" => "new", "hi" => "hello", "wow" => "what happened"};

# array.each
# array.my_each_with_index {|d, e| puts "Ind    endex #{e} is #{d}"}
# hash.my_each_with_index {|d, e| puts "#{d} => #{e}"}
# hash.my_each {|d| puts " #{d}"}
# array.my_select { |friend| friend != 4}
array.my_count
# array.my_none? { |friend| friend == 546476376}
# hash.my_select { |key, value| key != "wow"}