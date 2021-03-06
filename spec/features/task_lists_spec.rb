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

    first(:link, '+ Add Task').click
    fill_in "task[description]", with: "Some Great New Task"
    select "2015", from: "task[due_date(1i)]"
    select "06", from: "task[due_date(2i)]"
    select "06", from: "task[due_date(3i)]"
    click_on "Create Task"

    click_on "Logout"

    create_user email: "user2@example.com", name: "Some New", password: "password1", password_confirmation: "password1"
    visit signin_path

    click_on "Login"
    fill_in "Email", with: "user2@example.com"
    fill_in "Password", with: "password1"
    click_on "Login"
    expect(page).to_not have_content "Some Great New Task"
    expect(page).to have_content("Nothing here to see!")
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

  scenario 'User sees only their tasks' do
    create_user
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
    click_on 'Logout'

    create_user(name: "New User", email: "user2@example.com",
                password: "password2", password_confirmation: "password2")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user2@example.com"
    fill_in "Password", with: "password2"
    click_on "Login"

    expect(page).to_not have_content "A fun task"

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

  scenario 'User can add a new task' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    first(:link, '+ Add Task').click
    fill_in "task[description]", with: "New Task"
    select "2015", from: "task[due_date(1i)]"
    select "06", from: "task[due_date(2i)]"
    select "06", from: "task[due_date(3i)]"

    click_on "Create Task"
    expect(page).to have_content "New Task"
  end

  scenario 'User can complete a task and remove it from the list' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    first(:link, '+ Add Task').click
    fill_in "task[description]", with: "New Task"
    select "2015", from: "task[due_date(1i)]"
    select "06", from: "task[due_date(2i)]"
    select "06", from: "task[due_date(3i)]"


    click_on "Create Task"

    click_on "Complete task"

    expect(page).to_not have_content "New Task"
  end

  scenario 'User should see message when there are no tasks for a task list' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content "Nothing here to see!"
  end

  scenario 'Non-logged in user cannot visit new task path' do
   task_list =  TaskList.create!(name: "Work List")
    visit new_task_list_task_path(task_list)
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"

  end
  end