class Game < ApplicationRecord
	has_and_belongs_to_many :genres
	has_one_attached :image
	has_rich_text :review

	acts_as_votable
end

