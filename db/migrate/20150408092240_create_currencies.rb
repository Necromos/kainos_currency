class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :code
      t.integer :conversion_rate
      t.decimal :average_exchange_rate
      t.date :date

      t.timestamps null: false
    end
  end
end
