require 'rails_helper'

RSpec.describe 'Welcome Page', type: :feature do
    it 'displays welcome index page' do
        visit root_path
    
        expect(page).to have_content('Hop Hop')
        expect(page).to have_content('Hop Hop! - your ultimate travel planning companion.')
        expect(page).to have_button('Sign Up')
        expect(page).to have_button('Log In')
        expect(page).not_to have_button('Log Out')
    end

    it 'takes you to login' do
        visit root_path

        click_on ('Log In')

        expect(current_path).to eq(user_login_path)
    end

    it 'takes you to sign up' do 
        visit root_path

        click_on ('Sign Up')

        expect(current_path).to eq(register_user_path)
    end
end