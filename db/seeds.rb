ActiveRecord::Base.transaction do

  Faculty.create(id: 1, name: "No Faculty")
  Subject.create(id: 1, name: "No Subject")
end