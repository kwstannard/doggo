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


      expect(table_hash).to include(
        { 'Name'=>'Rex', 'Weekly Schedule'=>'Mon,Tue,Wed,Thu,Fri', 'Currently'=>'At Home' },
        { 'Name'=>'Spot', 'Weekly Schedule'=>'Mon', 'Currently'=>'At Home' }
      )

      ### Edit Dog

      click_on 'Dogs'

      click_on 'Rex'

      fill_in 'Name', with: 'Rexy'
      uncheck 'Wednesday'
      uncheck 'Thursday'
      uncheck 'Friday'
      click_on 'Save'

      expect(table_hash).to include(
        { 'Name'=>'Rexy', 'Weekly Schedule'=>'Mon,Tue', 'Currently'=>'At Home' },
        { 'Name'=>'Spot', 'Weekly Schedule'=>'Mon', 'Currently'=>'At Home' }
      )

      ### adding new schedules

      click_on 'Scheduling'

      click_on 'New Daily Schedule'
      fill_in 'Date', with: '2400-01-03'
      click_on 'Schedule Dogs'
      find('.dog', text: 'Rexy').fill_in('Truck Assignment', with: '1')
      find('.dog', text: 'Spot').fill_in('Truck Assignment', with: '2')
      click_on 'Save'

      click_on 'New Daily Schedule'
      fill_in 'Date', with: '2400-01-04'
      click_on 'Schedule Dogs'
      find('.dog', text: 'Rexy').fill_in('Truck Assignment', with: '1')
      expect(page).to_not have_content("Spot")
      click_on 'Save'

      expect(table_hash).to eq([
        { "Date"=>'2400-01-03', "Day Name"=>"Monday", "Dog Count"=>"2", "Truck Count"=>"2" },
        { "Date"=>'2400-01-04', "Day Name"=>"Tuesday", "Dog Count"=>"1", "Truck Count"=>"1" }
      ])

      ### edit existing schedules

      click_on '2400-01-03'
      find('.dog', text: 'Spot').fill_in('Truck Assignment', with: '1')
      click_on 'Save'

      expect(table_hash).to eq([
        { "Date"=>'2400-01-03', "Day Name"=>"Monday", "Dog Count"=>"2", "Truck Count"=>"1" },
        { "Date"=>'2400-01-04', "Day Name"=>"Tuesday", "Dog Count"=>"1", "Truck Count"=>"1" }
      ])
    end
  end

  example 'I get useful error messages' do
    role_play("Manager") do
      click_on "Scheduling"
      click_on "New Daily Schedule"
      click_on 'Schedule Dogs'
      expect(page).to have_content("Date can't be blank")

      fill_in 'Date', with: '2400-01-03'
      click_on 'Schedule Dogs'
      fill_in 'Date', with: ''
      click_on 'Save'

      expect(page).to have_content("Date can't be blank")
    end
  end
end
