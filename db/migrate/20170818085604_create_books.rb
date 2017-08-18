class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :field
      t.string :iban
      t.date :publish_year
      t.string :condition
      t.string :picture
      t.string :state
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
