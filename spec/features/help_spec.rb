require 'rails_helper'

describe 'help', type: :feature do

  it "should show help page" do
    visit help_path
    expect(page).to have_content 'Help'
  end
end