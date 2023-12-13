ActiveRecord::Base.transaction do
  puts "Create Faculty"
  Faculty.create(id: 1, name: "No Faculty")
  puts "Create Subject"
  Subject.create(id: 1, name: "No Subject")
  puts "Create Report Type"
  ReportType.create(id:1 , name_type: 'Khởi tạo', type_report: 'Chưa báo cáo')
  ReportType.create(id:2 , name_type: 'Lưu nháp', type_report: 'Chưa báo cáo')
  ReportType.create(id:3 , name_type: 'Chờ duyệt', type_report: 'Đang báo cáo')
  ReportType.create(id:4 , name_type: 'Cần bổ sung', type_report: 'Đang báo cáo')
  ReportType.create(id:5 , name_type: 'Đã duyệt', type_report: 'Đúng hạn')
  ReportType.create(id:6 , name_type: 'Đã duyệt', type_report: 'Trễ hạn')
end