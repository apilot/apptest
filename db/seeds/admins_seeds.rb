if Admin.count.zero?
  puts 'seeding admins'
  Admin.create!(email: 'admin@local.net', first_name: "first", last_name: "lastName", password:'123123', password_confirmation: "123123")
end
