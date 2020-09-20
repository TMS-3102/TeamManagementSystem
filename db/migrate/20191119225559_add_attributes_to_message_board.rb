class AddAttributesToMessageBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :message_boards, :number_stored, :integer
  end
end
