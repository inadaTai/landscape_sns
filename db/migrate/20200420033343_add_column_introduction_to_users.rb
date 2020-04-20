class AddColumnIntroductionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sex, :integer
    add_column :users, :web, :string
    add_column :users, :tel, :integer
    add_column :users, :introduction, :text
  end
end
