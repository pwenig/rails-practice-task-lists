class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :task_list_id
      t.date :due_date
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
