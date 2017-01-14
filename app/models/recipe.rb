class Recipe < ActiveRecord::Base

  #koristi se za show
  attr_accessor :stringIngredients

  belongs_to :user
  has_many :measurements, dependent: :destroy
  has_many :ingredients, through: :measurements
  has_many :ratings

  RECIPE_TITLE_REGEX = /\A[a-zA-Z[čćđšž][ ]]+\z/i

  validates :title, presence: true, format: {with: RECIPE_TITLE_REGEX, message: "Samo slova dopuštena"}
  validates :description, presence: true, length: { minimum: 10 }
  validates :user_id, presence: true

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100" }, :default_url => "/images/:style/default.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	searchable do
		text :title
	end
end
