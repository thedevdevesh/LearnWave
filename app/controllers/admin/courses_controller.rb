# frozen_string_literal: true

# Admin::CoursesController handles course-related actions for administrators.
class Admin::CoursesController < ApplicationController
  def index
    @admin_courses = Course.all
  end
end
