class Hash
  def to_key_indexed_array
    self.inject([]) { |acc, (k, v)| acc[k] = v; acc }
  end
end