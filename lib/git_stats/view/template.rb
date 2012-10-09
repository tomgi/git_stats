class GitStats::Template
  def initialize(name, layout)
    @name = name
    @layout = layout
    @template = Tilt.new("templates/#@name.haml")
  end

  def render(data)
    @layout.render { @template.render(data) }
  end
end