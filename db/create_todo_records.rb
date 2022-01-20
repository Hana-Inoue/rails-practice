todos = []
date = Date.new(2000, 1, 1)
now = DateTime.now

100_000.times do |number|
  todos << {
    name: "todo#{number}",
    due_date: date + number,
    completed_date: date + number,
    created_at: now,
    updated_at: now
  }
end

10.times do
  Todo.insert_all!(todos)
end
