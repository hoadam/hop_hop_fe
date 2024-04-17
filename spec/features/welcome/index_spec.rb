require 'rails_helper'

RSpec.describe 'Welcome Page', type: :feature do
    it 'displays welcome index page' do
        visit root_path

        expect(page).to have_content('Hop Hop')
        expect(page).to have_content('Hop Hop! - your ultimate travel planning companion.')
        expect(page).to have_button('Log in')
        expect(page).to have_button('Sign up')
        expect(page).not_to have_button('Log Out')
    end

    it 'takes you to login' do
        visit root_path

        click_on ('Log in')

        expect(current_path).to eq(new_user_session_path)
    end

    it 'takes you to sign up' do 
        visit root_path

        click_on ('Sign up')

        expect(current_path).to eq(new_user_registration_path)
    end
end