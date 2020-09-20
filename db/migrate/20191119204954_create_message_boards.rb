class CreateMessageBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :message_boards do |t|

      t.timestamps
    end
  end
end
