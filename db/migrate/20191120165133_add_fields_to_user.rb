class AddFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :is_student, :boolean, default: false
    add_column :users, :identification_number, :integer
    add_column :users, :is_liaison, :boolean, default: false
  end
end