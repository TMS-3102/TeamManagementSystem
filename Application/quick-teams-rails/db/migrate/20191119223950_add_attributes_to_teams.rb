class AddAttributesToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :name, :string
    add_column :teams, :liaison_id, :integer
    add_column :teams, :maximum_capacity, :integer
    add_column :teams, :minimum_capacity, :integer
    add_column :teams, :deadline, :date
    add_column :teams, :status, :boolean
  end
end
