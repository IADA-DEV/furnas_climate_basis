class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def to_date_b
    self.strftime('%d/%m/%Y')
  end
end
