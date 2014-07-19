require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do

  scenario 'User can view task lists' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
  end

  scenario 'User can add tasks to a task list' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    first(:link, '+ Add Task').click

    fill_in 'task[description]', with: "A fun task"
    select '2014', from: 'task[due_date(1i)]'
    select '09', from: 'task[due_date(2i)]'
    select '01', from: 'task[due_date(3i)]'

    click_on 'Create Task'

    expect(page).to have_content "A fun task"

  end

  scenario 'User cannot create a task without a description' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    first(:link, '+ Add Task').click

    fill_in 'task[description]', with: ""
    select '2014', from: 'task[due_date(1i)]'
    select '09', from: 'task[due_date(2i)]'
    select '01', from: 'task[due_date(3i)]'

    click_on 'Create Task'
    expect(page).to have_content "Your task could not be created"
  end

  scenario 'User can complete tasks' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    first(:link, '+ Add Task').click

    fill_in 'task[description]', with: "A fun task"
    select '2014', from: 'task[due_date(1i)]'
    select '09', from: 'task[due_date(2i)]'
    select '01', from: 'task[due_date(3i)]'

    click_on 'Create Task'
    click_on 'Complete'
    expect(page).to_not have_content "A fun task"

  end

end