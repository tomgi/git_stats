module Enumerable
	def first!(&block)
		matching = find(&block)
		if matching.nil?
			raise "Sequence contains no matching elements"
		else
			matching
		end
	end
end