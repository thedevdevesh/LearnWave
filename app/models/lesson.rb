# frozen_string_literal: true

# model to manage lessons data
class Lesson < ApplicationRecord
  has_one_attached :video

  belongs_to :course
end
