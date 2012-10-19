module ByFieldFinder
  def method_missing(name, *args, &block)
    field = name[/^by_(.*)$/, 1]
    field ? find { |e| e.send(field) == args.first } : super
  end
end