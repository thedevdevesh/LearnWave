# frozen_string_literal: true

# model for course data
class Course < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  has_many :lessons
  has_many :course_users
  has_and_belongs_to_many :categories

  def first_lesson
    lessons.order(:position).first
  end

  def next_lesson(current_user)
    return lessons.order(:position).first if current_user.blank?

    completed_lessons = current_user.lesson_users.includes(:lesson).where(completed: true).where(lessons: { course_id: id })
    started_lessons = current_user.lesson_users.includes(:lesson).where(completed: false).where(lesson: { course_id: id }).order(:position)

    return started_lessons.first.lesson if started_lessons.any?

    lessons = self.lessons.where.not(id: completed_lessons.pluck(:lesson_id)).order(:position)
    return self.lessons.order(:position).first unless lessons.any?

    lessons.first
  end
end
