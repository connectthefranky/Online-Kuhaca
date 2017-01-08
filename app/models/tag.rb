class Tag < ActiveRecord::Base
  has_many :recipes, through: :recipe_tags
  has_many :recipe_tags

  validates :title, uniqueness: true
end
