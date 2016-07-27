require 'rails_helper'

RSpec.feature "user can log in" do
  scenario "from the home page" do
    visit "/"
    mock_auth_hash
    click_on "Sign in with Twitter"

    expect(current_path).to eq "/dashboard"
  end

end
