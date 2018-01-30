# frozen_string_literal: true

require "rails_helper"

describe "data", type: :feature do
  before do
    visit "/step2"
    fill_in "First Name", with: "Napolean"
    fill_in "Last Name", with: "Dynamite"
    click_button "Next"

    fill_in "Email", with: "dancer.numberone@gmail.com"
    click_button "Next"

    select "18-25", from: "user[age_id]"
    fill_in "Feet", with: 5
    fill_in "Inches", with: 3
    fill_in "Weight", with: 160
    click_button "Next"

    select "Red", from: "user[fave_color]"
  end

  it "is remembered between steps" do
    visit "/step1"
    expect(page).to have_content("Napolean")

    visit "/step2"
    expect(page).to have_content("dancer.numberone@gmail.com")

    visit "/step4"
    expect(page).to have_content("Red")

    visit "/step3"
    expect(page).to have_content(160)
  end

  it "about place in the wizard is preserved" do
    visit "https://google.com"
    visit "/"

    expect(current_page).to eq("/step3")
  end
end
