class Recipe < ActiveRecord::Base

  #koristi se za show
  attr_accessor :stringIngredients

  belongs_to :user
  has_many :measurements
  has_many :ingredients, through: :measurements

  RECIPE_TITLE_REGEX = /\A[a-zA-Z[čćđšž][ ]]+\z/i

  validates :title, presence: true, format: {with: RECIPE_TITLE_REGEX, message: "Samo slova dopuštena"}
  validates :description, presence: true, length: { minimum: 10 }
  validates :user_id, presence: true

  has_attached_file :image, styles: {medium: "400x600"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
