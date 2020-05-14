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

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/LineLength, Lint/RedundantCopDisableDirective, Layout/EmptyLineAfterGuardClause
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

  def my_all?(block = false)
    a = true
    my_each do |element|
      c = if block

            if block.is_a?(Regexp)
              element = element.to_s unless element.is_a? String
              block === element # rubocop:disable Style/CaseEquality

            elsif !block.is_a?(Regexp)
              if block.is_a?(Method)
                element.is_a?(block)
              elsif block == element
                block == element
              else
                false
              end
            end

          elsif block_given?
            yield(element)
          elsif !block && !block_given?
            !!element # rubocop:disable Style/DoubleNegation
          end
      a &&= c
    end
    a
  end

  def my_any?(block = false)
    a = false
    my_each do |element|
      c = if block
            if block.is_a?(Regexp)
              element = element.to_s unless element.is_a? String
              block === element # rubocop:disable Style/CaseEquality

            elsif !block.is_a?(Regexp)
              if block.is_a?(Method)
                element.is_a?(block)
              elsif block == element
                block == element
              else
                false
              end
            end
          elsif block_given?
            yield(element)
          elsif !block && !block_given?
            !!element # rubocop:disable Style/DoubleNegation
          end
      a ||= c
    end
    a
  end

  def my_none?(block = false)
    a = false
    my_each do |element|
      c = if block
            if block.is_a?(Regexp)
              element = element.to_s unless element.is_a? String
              block === element # rubocop:disable Style/CaseEquality

            elsif !block.is_a?(Regexp)
              if block.is_a?(Method)
                element.is_a?(block)
              elsif block == element
                block == element
              else
                false
              end
            end
          elsif block_given?
            yield(element)
          elsif !block && !block_given?
            !!element # rubocop:disable Style/DoubleNegation
          end
      a ||= c
    end
    !a
  end

  def my_count(block = false)
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

  def my_inject(block = false, symbol = false)
    if block
      accumulator = block
      my_each do |element|
        if symbol.is_a?(Symbol)
          accumulator = eval "#{accumulator} #{symbol} #{element}" # rubocop:disable Security/Eval, Style/EvalWithLocation, Metrics/LineLength
        elsif !symbol.is_a?(Symbol)
          "#{symbol} is not a symbol nor a string"
        elsif !symbol
          accumulator = yield(accumulator, element)
        end
      end
    elsif !block
      my_each { |element| accumulator = element == self[0] ? self[0] : yield(accumulator, element) }
    end
    accumulator
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/LineLength, Lint/RedundantCopDisableDirective, Layout/EmptyLineAfterGuardClause
