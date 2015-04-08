class ChangeCurrencyAverageExchangeRateToFloat < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :currencies do |t|
        dir.up   { t.change :average_exchange_rate, :float }
        dir.down { t.change :average_exchange_rate, :decimal }
      end
    end
  end
end
