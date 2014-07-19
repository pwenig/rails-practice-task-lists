User.destroy_all
TaskList.destroy_all

User.create!(
  name: "Some User",
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password'
)

User.create!(
  name: "Some User2",
  email: 'user2@example.com',
  password: 'password2',
  password_confirmation: 'password2'
)

TaskList.create!(name: "Work List")
TaskList.create!(name: "Household Chores")
