ActiveRecord::Base.transaction do
  Faculty.create(id: 1, name: "No Faculty")
  Subject.create(id: 1, name: "No Subject")
  ReportType.create(id:1 , name_type: 'khoi tao', type_report: 'chua bao cao')
end