class AddParamsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :age, :integer
    add_column :users, :country, :string
    add_column :users, :university, :string
    add_column :users, :picture, :string
    add_column :users, :email_confirmed, :boolean, default: false
    add_column :users, :confirm_token, :string
  end
end
