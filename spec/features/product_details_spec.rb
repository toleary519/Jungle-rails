require 'rails_helper'

RSpec.feature "Visitor navigates to product details", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Vistitor sees a specific product details" do
    # ACT
    visit root_path

    find(:link, href: '/products/2', class: 'btn btn-default pull-right').click
    sleep 2
    save_screenshot
    expect(page).to have_css 'article.product-detail'

    # first('.product').click_on('Details')

    # # DEBUG
    # save_screenshot

    # # VERIFY
    # expect(page).to have_css 'description'
  end
end
