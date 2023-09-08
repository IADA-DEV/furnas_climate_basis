class Time
  def to_time_b
    self.strftime('%H:%M')
  end

  def to_dt
    self.strftime('%H:%M - %d/%m/%Y')
  end

  def to_dt_not_Y
    self.strftime('%H:%M - %d/%m').split(' - ')
  end

  def to_date_b
    self.strftime('%d/%m/%Y')
  end

  def to_brz
    self.in_time_zone('Brasilia')
  end

  def to_utc
    self.in_time_zone('UTC')
  end
end