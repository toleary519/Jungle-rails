require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "validates product initializes and saves" do
      @category = Category.new(name: "Home")
      @product = Product.new(name: 'Goldfish', price: 567, quantity: 1, category: @category)
      expect(@product).to be_valid
    end  
    it "validates product requires a name" do
      @category = Category.new(name: "Home")
      @product = Product.new(name: nil, price: 567, quantity: 1, category: @category)
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it "validates product requires a price" do
      @category = Category.new(name: "Home")
      @product = Product.new(name: 'Goldfish', price: nil, quantity: 1, category: @category)
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end 
    it "validates product requires a quantity" do
      @category = Category.new(name: "Home")
      @product = Product.new(name: 'Goldfish', price: 567, quantity: nil, category: @category)
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "validates product requires a category " do
      @category = Category.new(name: "Home")
      @product = Product.new(name: 'Goldfish', price: 567, quantity: 1, category: nil)
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end    
  end
end