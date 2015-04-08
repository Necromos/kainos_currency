class Currency < ActiveRecord::Base

  def name_by_code
    Currency.where(name: self.code).first
  end

  def average_by_code
    Currency.where(code: self.code).average(:average_exchange_rate)
  end

  def minimum_by_code
    Currency.where(code: self.code).minimum(:average_exchange_rate)
  end

  def maximum_by_code
    Currency.where(code: self.code).maximum(:average_exchange_rate)
  end

end
