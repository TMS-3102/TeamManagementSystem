class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :completed
      t.string :title
      t.date :deadline
      t.integer :order
      t.integer :priority
      t.integer :team_id
      t.timestamps
    end
  end
end
