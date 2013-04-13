require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest

  test 'show home page to users' do
    visit root_path
    find('h1:contains("Survey Website")')
  end
  
  test 'non logged in users' do
    visit root_path
    find('td:contains("Main Menu")')
    find('td:contains("No Menus")')
  end
  
end