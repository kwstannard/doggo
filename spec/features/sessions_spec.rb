require 'rails_helper'

RSpec.feature 'as a user' do
  example 'I get useful errors at login' do
    role_play("") do
      expect(page).to have_content("Missing Role")
    end
  end
end
