teacher1 = User.create!(name: "Teacher1", site_version: 1)
teacher2 = User.create!(name: "Teacher4", site_version: 1)
teacher3 = User.create!(name: "Teacher4", site_version: 1)
teacher4 = User.create!(name: "Teacher4", site_version: 1)
classroom1 = Classroom.create!(name: "Classroom1", teacher: teacher1)
classroom2 = Classroom.create!(name: "Classroom2", teacher: teacher2)
classroom3 = Classroom.create!(name: "Classroom3", teacher: teacher3)
classroom4 = Classroom.create!(name: "Classroom4", teacher: teacher4)

student1 = User.create!(name: "Student1", site_version: 1)
student2 = User.create!(name: "Student2", site_version: 1)
student3 = User.create!(name: "Student3", site_version: 1)
student4 = User.create!(name: "Student4", site_version: 1)
student5 = User.create!(name: "Student5", site_version: 1)
student6 = User.create!(name: "Student6", site_version: 1)
student7 = User.create!(name: "Student7", site_version: 1)
student8 = User.create!(name: "Student8", site_version: 1)
student9 = User.create!(name: "Student9", site_version: 1)

Enrollment.create!(student_id: student1.id, classroom_id: classroom1.id)
Enrollment.create!(student_id: student1.id, classroom_id: classroom2.id)

Enrollment.create!(student_id: student2.id, classroom_id: classroom1.id)
Enrollment.create!(student_id: student3.id, classroom_id: classroom1.id)
Enrollment.create!(student_id: student4.id, classroom_id: classroom1.id)
Enrollment.create!(student_id: student5.id, classroom_id: classroom1.id)

Enrollment.create!(student_id: student6.id, classroom_id: classroom2.id)
Enrollment.create!(student_id: student7.id, classroom_id: classroom2.id)
Enrollment.create!(student_id: student8.id, classroom_id: classroom2.id)
Enrollment.create!(student_id: student9.id, classroom_id: classroom2.id)



student10 = User.create!(name: "Uninfected", site_version: 1)
student11 = User.create!(name: "Uninfected", site_version: 1)
student12 = User.create!(name: "Uninfected", site_version: 1)
student13 = User.create!(name: "Uninfected", site_version: 1)
student14 = User.create!(name: "Uninfected", site_version: 1)
student15 = User.create!(name: "Uninfected", site_version: 1)
student16 = User.create!(name: "Uninfected", site_version: 1)
student17 = User.create!(name: "Uninfected", site_version: 1)
student18 = User.create!(name: "Uninfected", site_version: 1)


Enrollment.create!(student_id: student10.id, classroom_id: classroom3.id)

Enrollment.create!(student_id: student11.id, classroom_id: classroom3.id)
Enrollment.create!(student_id: student12.id, classroom_id: classroom3.id)
Enrollment.create!(student_id: student13.id, classroom_id: classroom3.id)
Enrollment.create!(student_id: student14.id, classroom_id: classroom3.id)
Enrollment.create!(student_id: student15.id, classroom_id: classroom3.id)
Enrollment.create!(student_id: student16.id, classroom_id: classroom4.id)
Enrollment.create!(student_id: student17.id, classroom_id: classroom4.id)
Enrollment.create!(student_id: student18.id, classroom_id: classroom4.id)


lone_student = User.create!(name: "Loner", site_version: 1)
