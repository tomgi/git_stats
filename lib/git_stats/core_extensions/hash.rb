class Hash
  def to_key_indexed_array(params = {})
    raise ArgumentError.new('all the keys must be numbers to convert to key indexed array') unless all? { |k, v| k.is_a? Numeric }
    min_size = params[:min_size] || 0
    default = params[:default]
    inject(Array.new(min_size, default)) { |acc, (k, v)| acc[k] = v; acc }.map { |e| e || default }
  end
end