# -*- encoding : utf-8 -*-
class Hash
  def to_key_indexed_array(params = {})
    raise ArgumentError.new('all the keys must be numbers to convert to key indexed array') unless all? { |k, v| k.is_a? Numeric }
    min_size = params[:min_size] || 0
    default = params[:default]
    inject(Array.new(min_size, default)) { |acc, (k, v)| acc[k] = v; acc }.map { |e| e || default }
  end

  def fill_empty_days!(params = {:aggregated => false})
    return self if self.empty?

    days_with_data = self.keys.map(&:to_date).sort.uniq
    prev = 0
    days_with_data.first.upto(days_with_data.last) do |day|
      if days_with_data.include? day
        prev = self[day]
      else
        self[day] = params[:aggregated] ? prev : 0
      end
    end
    self
  end
end
