class AddPriceToBooks < ActiveRecord::Migration[5.0]
  def change
    add_monetize :books, :price, currency: { present: false }
  end
end
