class Recipe < ActiveRecord::Base
	belongs_to :user
	has_many :measurements
	has_many :ingredients, through: :measurements
	accepts_nested_attributes_for :measurements, allow_destroy: true, reject_if: :all_blank

	has_attached_file :image, styles: { medium: "400x600"}
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
