class AddAttributesToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :title, :string
    add_column :messages, :post_date, :date
    add_column :messages, :priority, :integer
    add_column :messages, :content, :text
  end
end
