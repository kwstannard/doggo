require 'rails_helper'

RSpec.feature 'as a walker' do
  example 'I can complete a daily assignment and dogs can be tracked' do
    role_play("Manager") do
      click_on 'Dogs'

      click_on 'Add Dog'
      fill_in 'Name', with: 'Spot'
      check 'Monday'
      click_on 'Save'

      click_on 'Add Dog'
      fill_in 'Name', with: 'Rex'
      check 'Monday'
      click_on 'Save'

      click_on 'Scheduling'
      click_on 'New Daily Schedule'
      fill_in 'Date', with: '2400-01-03'
      click_on 'Schedule Dogs'
      find('.dog', text: 'Rex').fill_in('Truck Assignment', with: '1')
      find('.dog', text: 'Spot').fill_in('Truck Assignment', with: '1')
      click_on 'Save'
    end

    Timecop.freeze('2400-01-03')

    role_play("Walker") do
      click_on 'Start Today'
      select('Truck 1')
      click_on 'Go'

      find('.dogs').click_on 'Rex Picked Up'
    end

    role_play("Manager") do
      click_on 'Dogs'
      expect(table_hash).to include(
        { "Name"=>"Rex", "Weekly Schedule"=>"Mon", "Currently"=>"Picked Up" },
        { "Name"=>"Spot", "Weekly Schedule"=>"Mon", "Currently"=>"At Home" }
      )
    end

    role_play("Walker") do
      find('.dogs').click_on 'Spot Picked Up'
    end

    role_play("Manager") do
      click_on 'Dogs'
      expect(table_hash).to include(
        { "Name"=>"Rex", "Weekly Schedule"=>"Mon", "Currently"=>"Picked Up" },
        { "Name"=>"Spot", "Weekly Schedule"=>"Mon", "Currently"=>"Picked Up" }
      )
    end

    role_play("Walker") do
      click_on 'Arrived'
    end

    role_play "Manager" do
      click_on 'Dogs'
      expect(table_hash).to include(
        { "Name"=>"Rex", "Weekly Schedule"=>"Mon", "Currently"=>"Arrived" },
        { "Name"=>"Spot", "Weekly Schedule"=>"Mon", "Currently"=>"Arrived" }
      )
    end

    role_play "Walker" do
      click_on "Departed"
    end

    role_play "Manager" do
      click_on 'Dogs'
      expect(table_hash).to include(
        { "Name"=>"Rex", "Weekly Schedule"=>"Mon", "Currently"=>"Departed" },
        { "Name"=>"Spot", "Weekly Schedule"=>"Mon", "Currently"=>"Departed" }
      )
    end

    role_play("Walker") do
      find('.dogs').click_on 'Rex Dropped Off'
    end

    role_play "Manager" do
      click_on 'Dogs'
      expect(table_hash).to include(
        { "Name"=>"Rex", "Weekly Schedule"=>"Mon", "Currently"=>"Dropped Off" },
        { "Name"=>"Spot", "Weekly Schedule"=>"Mon", "Currently"=>"Departed" }
      )
    end

    role_play("Walker") do
      find('.dogs').click_on 'Spot Dropped Off'
    end

    role_play "Manager" do
      click_on 'Dogs'
      expect(table_hash).to include(
        { "Name"=>"Rex", "Weekly Schedule"=>"Mon", "Currently"=>"Dropped Off" },
        { "Name"=>"Spot", "Weekly Schedule"=>"Mon", "Currently"=>"Dropped Off" }
      )
    end

    role_play("Manager") do
      click_on 'Scheduling'
      click_on 'New Daily Schedule'
      fill_in 'Date', with: '2400-01-10'
      click_on 'Schedule Dogs'
      find('.dog', text: 'Rex').fill_in('Truck Assignment', with: '1')
      find('.dog', text: 'Spot').fill_in('Truck Assignment', with: '1')
      click_on 'Save'
    end

    Timecop.freeze('2400-01-10')

    role_play("Walker") do
      click_on 'Trips'
      click_on 'Start Today'
      click_on 'Go'
      expect(Trip.count).to eq(2)
    end
  end
end
