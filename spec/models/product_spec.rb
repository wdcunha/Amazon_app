require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'validations' do
    it 'requires a title' do
      #GIVEN: new Product record
      p = Product.new

      #WHEN:  validations are invoked
      p.valid?

      #THEN: we get an error on the title field
      expect(p.errors.messages).to have_key(:title)
    end

    it 'require an unique title' do
      #GIVEN: create 2 products
      p = Product.create!({ title: 'Car',
                            description: 'New brand',
                            price: 20_000
                            })
      p1 = Product.new({ title: 'Car'})

      #WHEN
      p1.valid?

      #THEN
      expect(p1.errors.messages).to have_key(:title)

    end

    it 'requires capitalizing of title after saving' do
      p = Product.new({title: 'capitalizing something'})

      p.save

      expect(p.title).to eq('Capitalizing something')
    end
  end

  describe 'validate other fields' do

    it 'requires a description' do
      #GIVEN: new Product record
      p = Product.new

      #WHEN:  validations are invoked
      p.valid?

      #THEN: we get an error on the title field
      expect(p.errors.messages).to have_key(:description)
    end
  end

  describe 'requires price grater than zero' do

    it 'requires price bigger than 0' do
      #GIVEN: new Product record
      p = Product.new({price: 1})

      #WHEN:  validations are invoked
      p.valid?

      #THEN: we get an error on the price field
      expect(p.errors.messages).to have_key(:price)
    end
  end


end







#
