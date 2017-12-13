class Product < ApplicationRecord
  belongs_to :user

  has_many :reviews, dependent: :destroy


  validates(
    :title, {
      presence: { message: 'must be provided' },
      uniqueness: { case_sensitive: false }
    }
  )

  validates(
    :price, {
      presence: { message: 'must be provided' },
      numericality: { greater_than: 0 }
    }
  )

  validates(
    :description, {
      presence: true,
      length: { minimum: 10, maximum: 2000 }
    }
  )

  scope :search, -> (str) {
    # find_by_sql("select * from products where title ILIKE '%#{str}%' UNION select * from products where description ILIKE '%#{str}%'")
    # where("title ILIKE '%#{str}%' OR description ILIKE '%#{str}%'")
    where("title ILIKE ? OR description ILIKE ?", "%#{str}%", "%#{str}%")
  }

  after_initialize :set_defaults
  before_save :capitalize_title

  private

  def set_defaults
    self.price ||= 1
  end

  def capitalize_title
    self.title = title.capitalize if title.present?
  end
end
