class RemoveIbanFromBooks < ActiveRecord::Migration[5.0]
  def change
    remove_column :books, :iban, :string
  end
end
