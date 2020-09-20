class CreateUsersAndTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams_users do |t|
      t.belongs_to :user
      t.belongs_to :team
    end
  end
end
