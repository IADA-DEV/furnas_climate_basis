class Date
  def to_date_b
    self.strftime('%d/%m/%Y')
  end

  def to_brz
    self.in_time_zone('Brasilia')
  end
end