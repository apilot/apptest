if Teacher.count.zero?
  puts 'seeding teachers'
  Teacher.create!(first_name: "first", middle_name: "second", last_name: "lastName", description: "Main teacher")
  Teacher.create!(first_name: "first2", middle_name: "second2", last_name: "lastName2", description: "second teacher")
  Teacher.create!(first_name: "first3", middle_name: "second3", last_name: "lastName3", description: "third teacher")
end
