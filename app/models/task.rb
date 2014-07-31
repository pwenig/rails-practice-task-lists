class Task < ActiveRecord::Base
belongs_to :task_list
belongs_to :user
  validates_presence_of :description
end