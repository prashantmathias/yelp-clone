require 'rails_helper'

feature 'Reviews' do
  before { Restaurant.create name: 'KFC' }

    scenario 'allows users to leave a review using a form' do
      sign_up
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'so so'
    end

    scenario 'displays an average rating for all reviews' do
      sign_up
      leave_review('So so', '3')
      click_link 'Sign out'
      sign_up(email: 'mathias@gmail.com', password: '123456', password_confirmation: '123456')
      leave_review('Great', '5')
      expect(page).to have_content('Average rating: ★★★★☆')
    end
end
