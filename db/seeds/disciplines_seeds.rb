if Discipline.count.zero?
  puts 'seeding Disciplines'
  %w(Графика Скетчинг).each do |name|
    Discipline.create!(name: name)
  end
end
