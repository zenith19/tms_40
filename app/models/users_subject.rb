class UsersSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :courses_subject
  belongs_to :subject

  def self.find_by_user(user_id)
    UsersSubject.find_by("user_id = ?", user_id)
  end
end
