class GitStats::GitActivity
  def by_hour
    @by_hour ||= Hash.new(0)
  end

  def by_wday
    @by_wday ||= Hash.new(0)
  end

  def by_wday_hour
    @by_wday_hour ||= Hash.new { |h, k| h[k] = Hash.new(0) }
  end
end