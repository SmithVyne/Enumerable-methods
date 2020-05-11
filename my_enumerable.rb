module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
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
    return to_enum(:my_each_with_index) unless block_given?
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
    return to_enum(:my_select) unless block_given?
    if self.is_a?(Array)
      result = []
      self.my_each { |element| result << element if yield(element) }

    elsif self.is_a?(Hash)
      result = {}
      self.my_each { |e_key, e_value| result[e_key] = e_value if yield(e_key, e_value) }
    end
    p result
  end

  def my_all?(block = false)
    a = true
    self.my_each do |element|
      if block
        c = element.is_a?(block)
      else
        c = yield(element)
      end
      a &&= c
    end
    p a
  end

  def my_any?(block = false)
    a = false
    self.my_each do |element|
      if block
        c = element.is_a?(block)
      else
        c = yield(element)
      end
      a ||= c
    end
    p a
  end

  def my_none?(block = false)
    a = false
    self.my_each do |element|
      if block
        c = element.is_a?(block)
      else
        c = yield(element)
      end
      a ||= c
    end
    p !a
  end

  def my_count(block = false)
    result = []
    self.my_each do |element|
      if block && element == block
        result << element
      elsif block_given? && yield(element)
        result << element
      elsif !block && !block_given?
        result << element
      end
    end
    a = result.length
    a
  end

  def my_map
    result = []
    self.my_each do |element|
      result << yield(element)
    end
    p result
  end

  def my_inject(block = false)
    if block
      accumulator = block
      self.my_each do |element|
        accumulator = yield(accumulator, element)
      end
       
    elsif !block
      self.my_each { |element| element == self[0] ? accumulator = self[0] : accumulator = yield(accumulator, element) }
    end
    p accumulator
  end
end