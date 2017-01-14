class Ingredient < ActiveRecord::Base
  has_many :measurements
  has_many :recipes, through: :measurements

  INGREDIENT_TITLE_REGEX = /\A[a-zA-Z[čćđšž][ ]]+\z/i
  validates :name, presence: true, format: {with: INGREDIENT_TITLE_REGEX, message: "Samo slova dopuštena"}, length: {minimum: 3}

  searchable do
		text :name
	end
end
