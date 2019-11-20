class AddCourseIdToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :course_id, :integer
  end
end
