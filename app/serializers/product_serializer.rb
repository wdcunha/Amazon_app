class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :sale_price, :tag_product, :favourites_count, :created_at, :updated_at

  belongs_to :user, key: :author
  has_many :reviews
  # has_many :tags, through: :taggings

  def tag_product
    # object.tags.pluck(:name).join(', ')
    object.tags.map(&:name).join(', ')
  end

  def title
    object.title.capitalize
  end

  def favourites_count
    object.favourites.count #this is faster
    # object.favourites.length
  end

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :full_name
  end

  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :body, :created_at, :updated_at, :author_full_name, :likes_count

        def author_full_name
          object.user&.full_name
        end

        def likes_count
          object.likes.count
        end
  end
end
