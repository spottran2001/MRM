ActiveRecord::Base.transaction do
  puts "Create Faculty"
  Faculty.create(id: 1, name: "No Faculty")
  puts "Create Subject"
  Subject.create(id: 1, name: "No Subject")
  puts "Create Report Type"
  ReportType.create(id:1 , name_type: 'khoi tao', type_report: 'chua bao cao')
  ReportType.create(id:2 , name_type: 'luu nhap', type_report: 'chua bao cao')
  ReportType.create(id:3 , name_type: 'cho duyet', type_report: 'dang bao cao')
  ReportType.create(id:4 , name_type: 'can bo sung', type_report: 'dang bao cao')
  ReportType.create(id:5 , name_type: 'da duyet', type_report: 'dung han')
  ReportType.create(id:6 , name_type: 'da duyet', type_report: 'tre han')
end