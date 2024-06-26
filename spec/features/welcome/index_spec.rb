require 'rails_helper'

RSpec.describe 'Welcome Page', type: :feature do
    it 'displays welcome index page' do
        visit root_path

        expect(page).to have_content('Hop Hop')
        expect(page).to have_link('Sign Up')
        expect(page).to have_link('Log In')
        expect(page).not_to have_link('Log Out')
    end

    it 'takes you to login' do
        visit root_path
        click_on ('Log In')

        expect(current_path).to eq(new_user_session_path)
    end

    it 'takes you to sign up' do
        visit root_path

        click_on ('Sign Up')

        expect(current_path).to eq(new_user_registration_path)
    end
end
