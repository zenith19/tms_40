class CoursesController < ApplicationController
  load_and_authorize_resource except: [:show]

  def show
    courses = current_user.courses
    @course = courses.last
    @subjects = @course.subjects
    @user_subjects = current_user.courses_subjects
    @activities = PublicActivity::Activity.order("created_at desc")
      .where owner_id: current_user.id, trackable_id: @course.id
  end
end
