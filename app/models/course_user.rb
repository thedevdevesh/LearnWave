# frozen_string_literal: true

class CourseUser < ApplicationRecord
  belongs_to :course
  belongs_to :user
end
