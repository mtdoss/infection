FactoryGirl.define do
  factory :user do
    site_version 1
  end

  factory :teacher, class: User do
    site_version 1
  end

  factory :student, class: User do
    site_version 1
  end
end
