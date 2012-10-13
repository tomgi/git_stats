module HashInitializable
  def initialize(params = {})
    raise "pass a Hash to initialize #{self.class}" unless params.is_a? Hash
    params.each { |k, v| instance_variable_set("@#{k}", v) }
  end
end