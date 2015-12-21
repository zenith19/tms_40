# #supervisors
supervisor1 = User.create! first_name: "test",
                           last_name: "test",
                           email: "test@test.com",
                           password: "password",
                           role: :supervisor
supervisor2 = User.create! first_name: "test1",
                           last_name: "test1",
                           email: "test1@test.com",
                           password: "password",
                           role: :supervisor
## trainees
99.times do |n|
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email      = "example-#{n+1}@test.com"
  password   = "password"
  User.create! first_name:  first_name,
               last_name: last_name,
               email: email,
               password: password
end

trainees = User.where "id > ?", 2

20.times do |s|
  subject = Subject.create! name: Faker::Lorem.word,
    description: Faker::Lorem.paragraph
  8.times do |t|
    subject.tasks.create! name: Faker::Lorem.word
  end
end

subjects = Subject.all

2.times do |c|
  course = Course.create! name: Faker::Lorem.word,
    description: Faker::Lorem.paragraph,
    start_date: Faker::Date.backward,
    end_date: Faker::Date.forward,
    status: :created

  course.subjects = subjects.sample 3  
  course.users = [supervisor1] + trainees.sample(5)
  course.save!
end

# Assign course
2.times do |uc|
  uid = "#{uc+1}"
  UsersCourse.create! user_id: uid,
                      course_id: 1
end

  5.times do |cs|
    sid = "#{cs+1}"
    CoursesSubject.create! subject_id: sid,
      course_id: 1
  end

  5.times do |cst|
    tid = "#{cst+1}"
    CoursesSubjectsTask.create! task_id: tid,
      courses_subject_id: 1
  end

  5.times do |cst|
    Activity.create! trackable_id: 1,
      owner_id: 3,
      owner_type: "User",
      trackable_type: "Course",
      key: "course.update"
  end

10.times do |us|
  csid = "#{us+1}"
  UsersSubject.create! user_id: 3,
                       courses_subject_id: csid
end
