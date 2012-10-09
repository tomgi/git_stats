class GitStats::GitActivity
  def by_hour
    @by_hour ||= Array.new(24, 0)
  end

  def by_wday
    @by_wday ||= Array.new(7, 0)
  end

  def by_wday_hour
    @by_wday_hour ||= Array.new(7) { Array.new(24, 0) }
  end

  def add_commit(date)
    self.by_hour[date.hour] += 1
    self.by_wday[date.wday] += 1
    self.by_wday_hour[date.wday][date.hour] += 1
  end
end