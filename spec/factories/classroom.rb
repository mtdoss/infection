FactoryGirl.define do
  factory :classroom do
    teacher
    name "Classroom"
    trait :with_5_students do
      after :create do |classroom|
        5.times do
          student = create(:student)
          enrollment = create(:enrollment, student_id: student.id,
                              classroom_id: classroom.id)
        end
      end
    end
  end
end
