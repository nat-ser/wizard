# frozen_string_literal: true

require "rails_helper"

describe "third page", type: :feature do
  before do
    visit onboarding_step3_path
  end

  it "form validates presense of age range" do
    click_button "Next"

    expect(page).to have_content("can't be blank")
  end

  it "form validates numericality for height feet field" do
    fill_in "feet", with: "hi"
    fill_in "inches", with: 3

    click_button "Next"
    expect(page).to have_content("Please enter your height as a number")
  end

  it "form does not validatte presense of weight" do
    select "18-25", from: "user[age_range]"
    fill_in "feet", with: 5
    fill_in "inches", with: 3
    click_button "Next"

    expect(current_path).to eq(validate_step_path)
  end

  it "validates that weight for numericality" do
    fill_in "Weight", with: "skinny"
    click_button "Next"

    expect(page).to have_content("Please enter a numerical weight")
  end

  it "form validates numericality for height feet field" do
    fill_in "Feet", with: 5
    fill_in "Inches", with: "meow"
    click_button "Next"

    expect(page).to have_content("Please enter your height as a number")
  end

  it "correctly-filled form submits and remembers info on return" do
    select "18-25", from: "user[age_range]"
    fill_in "Feet", with: 5
    fill_in "Inches", with: 3
    fill_in "Weight", with: 160

    click_button "Next"

    expect(current_path).to eq(onboarding_step4_path)

    visit onboarding_step3_path
    expect(find_field("Weight").value).to eq(160)
  end

  it "back button takes user back to previous step" do
    click_button "Back"

    expect(current_path).to eq(onboarding_step2_path)
  end
end
