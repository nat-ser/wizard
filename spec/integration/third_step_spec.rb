# frozen_string_literal: true

require "rails_helper"

describe "third page", type: :feature do
  before do
    visit "/step3"
  end

  it "form validates presense of both first and last name" do
    select "18-25", from: "user[age_id]"
    click_button "Next"

    expect(current_path).to eq("/step3")
    expect(page).to have_content("Please enter your age")
  end

  it "form does not validatte presense of weight" do
    fill_in "Age", with: 24
    fill_in "Feet", with: 5
    fill_in "Inches", with: 3
    select "18-25", from: "user[age_id]"
    click_button "Next"

    expect(current_path).to eq("/step4")
  end

  it "validates that weight for numericality" do
    fill_in "Weight", with: "skinny"
    click_button "Next"

    expect(page).to have_content("Please enter a numerical weight")
  end

  it "form validates numericality for height feet field" do
    fill_in "Feet", with: "hi"
    fill_in "Inches", with: 3

    click_button "Next"
    expect(page).to have_content("Please enter your height as a number")
  end

  it "form validates numericality for height feet field" do
    fill_in "Feet", with: 5
    fill_in "Inches", with: "meow"
    click_button "Next"

    expect(page).to have_content("Please enter your height as a number")
  end

  it "form can be submitted succesfully navigating user to next page" do
    select "18-25", from: "user[age_id]"
    fill_in "Feet", with: 5
    fill_in "Inches", with: 3
    fill_in "Weight", with: 160

    click_button "Next"

    expect(current_path).to eq("/step4")
  end

  it "back button takes user back to previous step" do
    click_button "Back"

    expect(current_path).to eq("/step2")
  end
end
