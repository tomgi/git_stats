require 'tilt'

class GitStats::Template
  def initialize(name)
    @name = name
    @layout = Tilt.new("templates/layout.haml")
    @template = Tilt.new("templates/#@name.haml")
  end

  def render(data)
    @layout.render { @template.render(data) }
  end
end