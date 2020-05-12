module Enumerable # rubocop:disable Metrics/ModuleLength
  def my_each
    return to_enum(:my_each) unless block_given?
    n = 0
    while n < length
      yield(self[n]) if is_a?(Array)
      yield(keys[n], self[keys[n]]) if is_a?(Hash)
      yield(self[n]) if is_a?(Range)
      n += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    n = 0
    while n < length
      yield(self[n], index(self[n])) if is_a?(Array)
      yield(keys[n], self[keys[n]]) if is_a?(Hash)
      yield(self[n]) if is_a?(Range)
      n += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    if is_a?(Array)
      result = []
      my_each { |element| result << element if yield(element) }

    elsif is_a?(Hash)
      result = {}
      my_each { |e_key, e_value| result[e_key] = e_value if yield(e_key, e_value) }
    end
    result
  end

  def my_all?(block = false) # rubocop:disable Metrics/PerceivedComplexity
    a = true
    my_each do |element|
      c = if block
            if block.is_a?(Regexp)
              element = element.to_s unless element.is_a? String
              block === element # rubocop:disable Style/CaseEquality

            elsif !block.is_a?(Regexp)
              element.is_a?(block)
            end
          elsif block_given?
            yield(element)
          else
            true
          end
      a &&= c
    end
    a
  end

  def my_any?(block = false) # rubocop:disable Metrics/PerceivedComplexity
    a = false
    my_each do |element|
      c = if block
            if block.is_a?(Regexp)
              element = element.to_s unless element.is_a? String
              block === element # rubocop:disable Style/CaseEquality

            elsif !block.is_a?(Regexp)
              element.is_a?(block)
            end
          elsif block_given?
            yield(element)
          else
            true
          end
      a ||= c
    end
    a
  end

  def my_none?(block = false) # rubocop:disable Metrics/PerceivedComplexity
    a = false
    my_each do |element|
      c = if block
            if block.is_a?(Regexp)
              element = element.to_s unless element.is_a? String
              block === element # rubocop:disable Style/CaseEquality

            elsif !block.is_a?(Regexp)
              element.is_a?(block)
            end
          elsif block_given?
            yield(element)
          else
            true
          end
      a ||= c
    end
    !a
  end

  def my_count(block = false) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    result = []
    my_each do |element|
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
    return to_enum(:my_map) unless block_given?
    result = []
    my_each do |element|
      result << yield(element)
    end
    result
  end

  def my_inject(block = false)
    if block
      accumulator = block
      my_each do |element|
        accumulator = yield(accumulator, element)
      end
    elsif !block
      my_each { |element| accumulator = element == self[0] ? self[0] : yield(accumulator, element) }
    end
    accumulator
  end
end
