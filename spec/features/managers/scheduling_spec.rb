require 'rails_helper'

RSpec.feature 'as a manager' do
  scenario 'I can set a weekly schedule for a dog and assign dogs to truck-days' do
    role_play('Manager') do
      ### Add dogs

      click_on "Dogs"

      click_on 'Add Dog'
      fill_in 'Name', with: 'Rex'
      check 'Monday'
      check 'Tuesday'
      check 'Wednesday'
      check 'Thursday'
      check 'Friday'
      click_on 'Save'

      click_on 'Add Dog'
      fill_in 'Name', with: 'Spot'
      check 'Monday'
      click_on 'Save'


      expect(table_hash).to eq([
        { 'Name'=>'Rex', 'Weekly Schedule'=>'Mon,Tue,Wed,Thu,Fri' },
        { 'Name'=>'Spot', 'Weekly Schedule'=>'Mon' }
      ])
    end
  end
end
