class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user


  #Validate that body is optional but the rating is required and must be a number between 1 and 5 inclusive
  validates :body, presence: true;
  validates( :rating, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    message: "Rating must be between 1 and 5"
  })
end
