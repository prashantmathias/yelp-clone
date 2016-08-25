require 'rails_helper'

feature 'endorising reviews' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: "It was an abomination")
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    sign_up
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

  scenario 'a user can see how many endorsements have been made' do
    sign_up
    visit '/restaurants'
    2.times { click_link 'Endorse Review' }
    expect(page).to have_content("2 endorsements")
  end
end
