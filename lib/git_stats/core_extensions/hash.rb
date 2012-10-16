class Hash
  def to_key_indexed_array
    raise ArgumentError.new('all the keys must be numbers to convert to key indexed array') unless all? { |k, v| k.is_a? Numeric }
    inject([]) { |acc, (k, v)| acc[k] = v; acc }
  end
end