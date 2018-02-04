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

  it "form does not validate presense of weight" do
    select "18-25", from: "user[age_range]"
    find("#user_feet_tall").set(5)

    # fill_in ".user_feet_tall", with: 5
    click_button "Next"
    expect(current_path).to eq(onboarding_step4_path)
  end

  it "validates weight for numericality" do
    fill_in "Weight", with: "skinny"
    click_button "Next"

    expect(page).to have_content("is not a number")
  end

  it "form validates numericality for height field" do
    find("#user_feet_tall").set(5)
    find("#user_inches_tall").set("mewo")
    click_button "Next"

    expect(page).to have_content("is not a number")
  end

  it "correctly-filled form submits and remembers info on return" do
    select "18-25", from: "user[age_range]"
    find("#user_feet_tall").set(5)
    fill_in "Weight", with: 160

    click_button "Next"

    expect(current_path).to eq(onboarding_step4_path)

    visit onboarding_step3_path
    find("#user_feet_tall").set(5)
    find("#user_inches_tall").set(5)

  end

  it "back button takes user back to previous step" do
    click_link "Back"

    expect(current_path).to eq(onboarding_step2_path)
  end
end
