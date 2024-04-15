require 'rails_helper'

RSpec.describe UserDecorator do
    describe '#full_name' do
        it 'returns the combined first and last name' do
            user = User.new(name: 'Selena H')
            decorator = UserDecorator.new(user)
            expect(decorator.full_name).to eq('Selena H')
        end
    end
end
