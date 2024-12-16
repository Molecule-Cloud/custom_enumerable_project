module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_array = []
    my_each { |i| new_array << i if yield(i) }
    new_array
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?

    my_each { |i| return false unless yield(i) }
    true
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    my_each { |item| return true if yield(item) }
    false
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    my_each { |i| return false if yield(i) }
    true
  end

  def my_count(arg = nil)
    i = 0
    if arg
      my_each { |item| i += 1 if item == arg }
    elsif block_given?
      my_each { |item| i += 1 if yield(item) }
    else
      my_each { i += 1 }
    end
    i
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    new_array = []
    my_each { |i| new_array << yield(i) }
    new_array
  end

  def my_inject(initial = nil, symbol = nil)
    acc = initial.nil? ? self[0] : initial
    start_index = initial.nil? ? 1 : 0
    if symbol
      my_each_with_index { |item, index| acc = acc.send(symbol, item) if index >= start_index }
    else
      my_each_with_index { |item, index| acc = yield(acc, item) if index >= start_index }
    end
    acc
  end
end

# Extend the Array class to include the Enumerable module
class Array
  include Enumerable
end
