# frozen_string_literal: true

class LessonUser < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
end
