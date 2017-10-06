class ChangePublishYearOfBooksToInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :books, :publish_year, :date
    add_column :books, :publish_year, :integer
  end
end
