class Time
  def to_time_br
    self.in_time_zone('Brasilia').strftime('%H:%M')
  end

  def to_date_br
    self.in_time_zone('Brasilia').strftime('%d/%m/%Y')
  end

  def to_brz
    self.in_time_zone('Brasilia')
  end
end