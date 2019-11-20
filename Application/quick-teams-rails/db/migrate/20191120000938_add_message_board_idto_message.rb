class AddMessageBoardIdtoMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :message_board_id, :integer
  end
end
