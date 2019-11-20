class AddTeamIdtoMessageBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :message_boards, :team_id, :integer
  end
end
