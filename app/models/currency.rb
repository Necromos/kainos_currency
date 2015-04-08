class Currency < ActiveRecord::Base

  def average_by_name
    Currency.where(name: self.name).average(:average_exchange_rate)
  end

  def minimum_by_name
    Currency.where(name: self.name).minimum(:average_exchange_rate)
  end

  def maximum_by_name
    Currency.where(name: self.name).maximum(:average_exchange_rate)
  end

end
