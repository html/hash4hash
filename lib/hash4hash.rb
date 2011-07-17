# Hash4hash

[TrueClass, FalseClass, NilClass].each do |cl|
  cl.class_eval do
    def value4hash
      inspect
    end
  end
end

String.class_eval do
  def value4hash
    self
  end
end

Symbol.class_eval do
  def value4hash
    if Hash4Hash::OPTIONS[:symbol_as_string]
      to_s.value4hash
    else
      raise "Unimplemented"
    end
  end
end

Array.class_eval do
  def value4hash
    if Hash4Hash::OPTIONS[:array_order_matters]
      map(&:value4hash).inspect
    else
      map(&:value4hash).sort.inspect
    end
  end
end

Hash.class_eval do
  def value4hash
    to_a.value4hash
  end
end

module Hash4Hash
  mattr_accessor :OPTIONS
  OPTIONS = {
    :symbol_as_string => true,
    :array_order_matters => false
  }
end
