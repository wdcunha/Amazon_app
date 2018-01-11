class Product < ApplicationRecord
  belongs_to :user

  has_many :reviews, dependent: :destroy

  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites
  

  before_validation :capitalize_title
  validates :price, presence: true
  validates :price, numericality: {greater_than: 0}
  validates :title, presence: true, uniqueness: true
  validates :sale_price, presence: true

  validates(
    :title, {
      presence: { message: 'must be provided' },
      uniqueness: { case_sensitive: false }
    }
  )

  # validates(
  #   :price, {
  #     presence: { message: 'must be provided' },
  #     numericality: { greater_than: 0 }
  #   }
  # )

  validates(
    :description, {
      presence: true,
      length: { minimum: 10, maximum: 2000 }
    }
  )
  #
  # scope :search, -> (str) {
  #   # find_by_sql("select * from products where title ILIKE '%#{str}%' UNION select * from products where description ILIKE '%#{str}%'")
  #   # where("title ILIKE '%#{str}%' OR description ILIKE '%#{str}%'")
  #   where("title ILIKE ? OR description ILIKE ?", "%#{str}%", "%#{str}%")
  # }
  #
  validate :sale_price_must_be_less_than_or_equal_to_price

  def sale_price_must_be_less_than_or_equal_to_price
    if price.present? && sale_price.present? && sale_price > price
      errors.add(:sale_price, "can't be greater than price")
    end
  end

  after_initialize :set_defaults
  #
  def on_sale?
    if price.present? && sale_price.present? && sale_price < price
      true
    end
  end

  private
  #
  def set_defaults
    self.price ||= 10
    self.sale_price ||= self.price #if there's no sale_price, take price as set_default

  end
  #
  def capitalize_title
    self.title = title.capitalize if title.present?
  end


end
