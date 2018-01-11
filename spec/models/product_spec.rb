require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let(:user) { FactoryBot.create(:user) }

  describe 'validations' do
    it 'requires a title' do
      #GIVEN: new Product record
      p = Product.new

      #WHEN:  validations are invoked
      p.valid?

      #THEN: we get an error on the title field
      expect(p.errors.messages).to have_key(:title)
    end

    it 'requires a description' do
      #GIVEN: new Product record
      user = User.create!(first_name: 'Jon', last_name: 'Snow', email: 'j@s.com', password:
           'supersecret')
      p = Product.create(title:'unique title', price: 300, user: user)

      #WHEN:  validations are invoked
      p.valid?

      #THEN: we get an error on the title field
      expect(p.errors.messages).to have_key(:description)
    end

    it 'requires price bigger than 0' do
      #GIVEN: new Product record
      p = Product.new({price: 0})

      #WHEN:  validations are invoked
      p.valid?

      #THEN: we get an error on the price field
      expect(p.errors.messages).to have_key(:price)
    end

    it 'require an unique title' do
      #GIVEN: create 2 products
      p = Product.create!({ title: 'Car',
                            description: 'New brand came here',
                            price: 20_000,
                            user: user
                            })
      p1 = Product.new({ title: 'Car'})

      #WHEN
      p1.valid?

      #THEN
      expect(p1.errors.messages).to have_key(:title)

    end

  it 'must have sale price less than the price' do
    user = User.create(first_name: 'Jon', last_name: 'Snow',  email: 'j@s.com', password: 'supersecret')
    p1 = Product.new(title:'unique_title1', description: 'blah blah blah blah', price: 10, sale_price: 12, user: user)
    p1.valid?
    expect(p1.errors.messages).to have_key(:sale_price)
  end


  end

  describe 'capitalizing' do
    it 'returns a capitalized title after saved' do
      p = Product.new({ title: "capitalizing something" })

      p.save

      expect(p.title).to eq("Capitalizing something")
    end
  end

  describe 'sale price' do
    it 'set the sale price to price if sale price doesn\' exist' do
      user = User.create!(first_name: 'Jon', last_name: 'Snow', email: 'j@s.com', password:
      'supersecret')
      p1 = Product.create(title:'unique title', description: 'description blah', price: 300, user: user)
      result = p1.sale_price
      expect(result).to eq(300)
    end
  end

  describe '.on_sale?' do
    it 'returns true or false' do
      user = User.create(first_name: 'Jon', last_name: 'Snow',  email: 'j@s.com', password: 'supersecret')
      p = Product.create!(title:'unique_title1', description: 'blah blah blah blah', price: 10, sale_price: 9, user: user)
      result = p.on_sale?
      expect(result).to be true
    end
  end


end







#
