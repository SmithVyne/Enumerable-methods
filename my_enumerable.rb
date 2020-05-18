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

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/LineLength, Lint/RedundantCopDisableDirective, Layout/EmptyLineAfterGuardClause, Performance/RedundantBlockCall, Style/DoubleNegation, Style/EvalWithLocation, Style/RedundantSelf, Security/Eval, Lint/UnneededDisable
  def my_each_with_index(&block)
    return to_enum(:my_each_with_index) unless block_given?
    n = 0
    while n < length
      block.call(self[n], n) if is_a?(Array)
      block.call(keys[n], self[keys[n]]) if is_a?(Hash)
      block.call(self[n]) if is_a?(Range)
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

  def my_all?(*args, &block)
    a = true
    my_arg = args[0]

    my_each do |element|
      c = if block.is_a?(Proc)
            block.call(element)
          elsif my_arg
            if my_arg.is_a?(Module)
              element.is_a?(my_arg)
            elsif my_arg.is_a?(Regexp)
              element = element.to_s unless element.is_a? String
              my_arg === element # rubocop:disable Style/CaseEquality
            elsif my_arg == element
              my_arg == element
            end
          elsif !my_arg && !block
            !!element
          end
      a &&= c
    end
    !!a
  end

  def my_any?(*args, &block)
    a = false
    my_arg = args[0]

    my_each do |element|
      c = if block.is_a?(Proc)
            block.call(element)
          elsif my_arg
            if my_arg.is_a?(Module)
              element.is_a?(my_arg)
            elsif my_arg.is_a?(Regexp)
              element = element.to_s unless element.is_a? String
              my_arg === element # rubocop:disable Style/CaseEquality
            elsif my_arg == element
              my_arg == element
            end
          elsif !my_arg && !block
            !!element
          end
      a ||= c
    end
    !!a
  end

  def my_none?(*args, &block)
    a = false
    my_arg = args[0]

    my_each do |element|
      c = if block.is_a?(Proc)
            block.call(element)
          elsif my_arg
            if my_arg.is_a?(Module)
              element.is_a?(my_arg)
            elsif my_arg.is_a?(Regexp)
              element = element.to_s unless element.is_a? String
              my_arg === element # rubocop:disable Style/CaseEquality
            elsif my_arg == element
              my_arg == element
            end
          elsif !my_arg && !block
            !!element
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

  def my_map(&block)
    return to_enum(:my_map) unless block_given?
    my_self = self.is_a?(Range) ? self.to_a : self
    result = []
    my_self .my_each do |element|
      result << block.call(element)
    end
    result
  end

  def my_inject(*args, &block)
    my_self = self.is_a?(Range) ? self.to_a : self

    if args[0].is_a?(Integer)
      if args[1].is_a?(Symbol)
        accumulator = args[0]
        my_self.my_each do |element|
          accumulator = eval "#{accumulator} #{args[1]} #{element}"
        end
      elsif block.is_a?(Proc)
        accumulator = args[0]
        my_self.my_each do |element|
          accumulator = block.call(accumulator, element)
        end
      end
    elsif args[0].is_a?(Symbol)
      accumulator = my_self[0]
      n = 1
      while n < my_self.length
        accumulator = eval "#{accumulator} #{args[0]} #{my_self[n]}"
        n += 1
      end
    elsif !args[0] && block.is_a?(Proc)
      accumulator = my_self[0]
      n = 1
      while n < my_self.length
        accumulator = block.call(accumulator, my_self[n])
        n += 1
      end
    end
    accumulator
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/LineLength, Lint/RedundantCopDisableDirective, Layout/EmptyLineAfterGuardClause, Performance/RedundantBlockCall, Style/DoubleNegation, Style/EvalWithLocation, Style/RedundantSelf, Security/Eval, Lint/UnneededDisable
