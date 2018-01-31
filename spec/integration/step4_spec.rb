# frozen_string_literal: true

require "rails_helper"

describe "fourth page", type: :feature do
  before do
    visit "/step4"
  end

  it "form validates presense of favorite color" do
    click_button "Submit"

    expect(page).to have_content("Please enter your favorite color")
  end

  it "form can be submitted with a custom option" do
    select "Other", from: "user[fave_color]"
    fill_in "Custom color", with: "special snowflake white"
    click_button "Submit"

    expect(current_path).to eq("/step5")
  end

  it "form can be submitted succesfully navigating user to next page" do
    select "Red", from: "user[fave_color]"
    click_button "Submit"

    expect(current_path).to eq("/step5")
    expect(page).to have_content("Thanks! We hope your form experience
      was unforgettable")
  end

  it "back button takes user back to previous step" do
    click_button "Back"

    expect(current_path).to eq("/step3")
  end
end
