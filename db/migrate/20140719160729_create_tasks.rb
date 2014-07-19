class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :description
      t.date :due_date
      t.integer :task_list_id
    end
  end
end
