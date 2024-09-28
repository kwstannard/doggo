require 'rails_helper'

RSpec.describe 'as a manager' do
  example 'I get useful error messages' do
    role_play("Manager") do
      click_on 'Dogs'
      click_on 'Add Dog'
      click_on 'Save'

      expect(page).to have_content("Name can't be blank")

      fill_in 'Name', with: 'Rex'
      click_on 'Save'

      click_on 'Rex'
      fill_in 'Name', with: ''
      click_on 'Save'

      expect(page).to have_content("Name can't be blank")
    end
  end
end
