require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'name exists' do
      it 'validates that :name is present' do
        @category = Category.create(name: "Random")
        @product = Product.new(name:nil, price_cents:1, quantity:1, category:@category)
        @save = @product.save
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end
    context 'Price exists' do
      it 'validates that :price_cents is present' do
        @category = Category.create(name: "Random")
        @product = Product.new(name:'n', price_cents:nil, quantity:1, category:@category)
        @save = @product.save
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end
    context 'Quantity exists' do
      it 'validates that :quantity is present' do
        @category = Category.create(name: "Random")
        @product = Product.new(name:'n', price_cents:1, quantity:nil, category:@category)
        @save = @product.save
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end
    context 'Category exists' do
      it 'validates that :category_id is present' do
        @product = Product.new(name:'l', price_cents:1, quantity:1, category:nil)
        @save = @product.save
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end
  end
end
