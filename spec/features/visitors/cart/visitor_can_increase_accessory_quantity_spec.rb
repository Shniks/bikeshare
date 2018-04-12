require 'rails_helper'

describe 'As a Visitor' do
  describe 'When I visit cart_path' do
    context 'I increase the quantity of an accessory in the cart' do
      scenario 'I see the quantity for that accessory increase' do
        accessories = create_list(:accessory, 2)
        accessory = accessories[1]

        visit accessories_path

        within(".accessory_#{accessory.id}") do
          click_on 'Add to Cart'
        end

        expect(page).to have_content(accessory.title)
        expect(page).to have_content(accessory.description)
        expect(page).to have_content(accessory.price)

        visit cart_path

        find(".increase_quantity_#{accessories[1].id}").click

        expect(current_path).to eq(cart_path)
        expect(page).to have_content("Subtotal: $10.00")
        expect(page).to have_content("Quantity: 2")
        expect(page).to have_content("Total: $10.00")
      end
    end
  end
end
