class AddStudentIdRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :team_id, :integer
  end
end
