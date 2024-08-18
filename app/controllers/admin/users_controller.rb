# frozen_string_literal: true

# Admin::UsersController handles user-related actions for administrators.
class Admin::UsersController < AdminController
  def index
    @admin_users = if params[:query].present?
                     User.where('email LIKE ?', "%#{params[:query]}%").order(created_at: :desc)
                   else
                     User.all.order(created_at: :desc)
                   end
  end

  def show
    @admin_user = User.find(params[:id])
    @user_started_courses = @admin_user.lesson_users&.joins(:lesson)&.pluck(:course_id)&.uniq
    @admin_courses = Course.where(id: @user_started_courses)
    return unless @user_started_courses.present?

    @user_course_progresses = @user_started_courses.map do |course_id|
      course_lessons = Course.find(course_id).lessons.count
      completed_lessons = @admin_user&.lesson_users&.joins(:lesson)&.where(completed: true, lesson: { course: course_id })&.count
      { course_id:, completed_percentage: (completed_lessons.to_f / course_lessons.to_f * 100).to_i }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to admin_users_path
  end
end
