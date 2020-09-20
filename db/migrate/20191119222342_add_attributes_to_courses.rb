class AddAttributesToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :name, :string
    add_column :courses, :code, :string
  end
end
