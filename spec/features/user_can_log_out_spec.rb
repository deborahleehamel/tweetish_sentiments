require 'rails_helper'

RSpec.feature "user can log out" do
  scenario "from the home page" do
    visit "/"
    mock_auth_hash
    click_on "Sign in with Twitter"

    expect(current_path).to eq "/dashboard.mock_user_name"
    expect(page).to have_content("Log Out")
    expect(page).to_not have_content("Sign in with Twitter")

    click_on "Log Out"

    expect(current_path).to eq root_path
    expect(page).to have_content("Sign in with Twitter")
    expect(page).to_not have_content("Log Out")
  end

end
