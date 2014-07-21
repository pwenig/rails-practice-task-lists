class Task < ActiveRecord::Base
  belongs_to :task_list
  belongs_to :user
  validates :description, :presence => {:message => "Your task could not be created"}

end