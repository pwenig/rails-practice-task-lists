require 'rails_helper'

describe Task do

  it 'validates presence of task description' do
    task = Task.new(name: "foo")
    expect(task).to have(0).errors_on(:name)

    task = Task.new(name: "")
    expect(task).to have(1).errors_on(:name)
  end

end