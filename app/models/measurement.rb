class Measurement < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe

  MEASUREMENT_MEASURE_REGEX = /([0-9]*[ ])*([a-z]|[A-Z]|[čćđšž]|[()])+[ ]*\z/i

  validates :measure, presence: true, format: {with: MEASUREMENT_MEASURE_REGEX, message: "sadrži jednu ili niti jednu brojku te razmak i zatim točno jednu riječ."}, length: {maximum: 15}
  validates :ingredient_id, presence: true
  validates :recipe_id, presence: true

end
