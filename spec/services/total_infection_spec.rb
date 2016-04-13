require 'spec_helper'

RSpec.describe TotalInfection do
  let(:student) { create(:student) }
  let(:student2) { create(:student) }
  let(:classroom) { create(:classroom, :with_5_students) }
  let(:classroom2) { create(:classroom, :with_5_students) }

  it 'infects a users direct connections' do
    create(:enrollment, student_id: student.id, classroom_id: classroom.id)
    TotalInfection.new(user_id: student.id, new_version_number: 2).call
    classroom.students.each do |student|
      student.reload
      expect(student.site_version).to eq(2)
    end
    classroom.teacher.reload
    expect(classroom.teacher.site_version).to eq(2)
  end

  it 'infects a users indirect connections' do
    create(:enrollment, student_id: student.id, classroom_id: classroom.id)
    create(:enrollment, student_id: student2.id, classroom_id: classroom.id)
    create(:enrollment, student_id: student2.id, classroom_id: classroom2.id)
    students = classroom.students + classroom2.students
    teachers = [classroom.teacher, classroom2.teacher]
    all_connected_users = students + teachers

    TotalInfection.new(user_id: student.id, new_version_number: 2).call
    all_connected_users.each do |connected_user|
      connected_user.reload
      expect(connected_user.site_version).to eq(2)
    end
  end
end
