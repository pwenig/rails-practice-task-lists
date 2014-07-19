require 'rails_helper'

describe Task do

  it 'creates a new task' do
    task = Task.new(description: "New Task", due_date: "2014-10-09")
    expect(task).to be_valid
  end

  it 'tests task validations' do
    task = Task.new(description: "", due_date: "2014-10-09")
    expect(task).to_not be_valid
  end

  
end