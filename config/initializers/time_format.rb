class Time
  def to_time_br
    self.utc.strftime('%H:%M')
  end
end