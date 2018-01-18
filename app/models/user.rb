class User < ApplicationRecord
  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

  has_many :favourites, dependent: :destroy
  has_many :favourited_products, through: :favourites, source: :product

  has_many :votes, dependent: :destroy
  has_many :voted_reviews, through: :votes, source: :review

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # validate the email field as format and if it's filled
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  # `validates` can take multiple column names as its first arguments. All
  # validation rules provided will apply all given columns.
  validates :first_name, :last_name, presence: true
  before_create :generate_api_key

  def full_name
    "#{first_name} #{last_name}" #put self if wants do writ, not for reading
  end

  private
  def generate_api_key
    # We may accidently generate an api key that a user already owns.
    # To prevent from saving a duplicate key, we'll loop until
    # we can't find any users with that key.
    loop do
      # SecureRandom.hex(32) will generate a large string of random hex
      # characters (i.e A-F & 0-9)
      # We'll use this as user's api key for authentication with our
      # web api.
      self.api_key = SecureRandom.hex(32)
      break unless User.exists?(api_key: api_key)
    end
  end

end
