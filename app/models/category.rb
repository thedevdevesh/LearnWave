# model to manage category data
class Category < ApplicationRecord
  has_and_belongs_to_many :courses
end
