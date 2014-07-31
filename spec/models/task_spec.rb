require 'rails_helper'

describe Task do

<<<<<<< HEAD
  it 'validates presence of task description' do
    task = Task.new(name: "foo")
    expect(task).to have(0).errors_on(:name)

    task = Task.new(name: "")
    expect(task).to have(1).errors_on(:name)
  end

=======
  it 'creates a new task' do
    task = Task.new(description: "New Task", due_date: "2014-10-09")
    expect(task).to be_valid
  end

  it 'tests task validations' do
    task = Task.new(description: "", due_date: "2014-10-09")
    expect(task).to_not be_valid
  end

  
>>>>>>> v2
end