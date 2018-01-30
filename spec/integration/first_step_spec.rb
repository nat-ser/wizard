# frozen_string_literal: true

require "rails_helper"

describe "first page", type: :feature do
  before do
    visit "/step1"
  end

  it "form validates presense of both first and last name" do
    fill_in "First Name", with: "Napolean"
    click_button "Next"

    expect(current_path).to eq("/step1")
    expect(page).to have_content("Please enter your last name")
  end

  it "form can be submitted succesfully navigating user to next page" do
    fill_in "First Name", with: "Napolean"
    fill_in "Last Name", with: "Dynamite"
    click_button "Next"

    expect(current_path).to eq("/step2")
  end
end
