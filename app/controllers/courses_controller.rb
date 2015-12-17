class CoursesController < ApplicationController
  load_and_authorize_resource :course

  def show
    courses = current_user.courses
    @course = courses.last
    @subjects = @course.subjects
    @activities = PublicActivity::Activity.order("created_at desc")
      .where owner_id: current_user.id, trackable_id: @course.id
  end
end
