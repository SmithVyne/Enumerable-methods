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
    result = {}
    if self.is_a?(Array)
      self.my_each{|element| result << element if yield(element)}

    elsif self.is_a?(Hash)
      self.my_each{|e_key, e_value| result[e_key] = e_value if yield(e_key, e_value)}
    end
    p result
  end

end

array = [1, 4, 56, 6, 7, 23, 5, 7, 3, 67, 8]
hash = {"hey" => "new", "hi" => "hello", "wow" => "what happened"};

# array.each
# array.my_each_with_index {|d, e| puts "Ind    endex #{e} is #{d}"}
# hash.my_each_with_index {|d, e| puts "#{d} => #{e}"}
# array.my_select { |friend| friend != 4}
hash.my_select { |key, value| key != "wow"}