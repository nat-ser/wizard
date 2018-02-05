# frozen_string_literal: true

require "rails_helper"

describe "third page", type: :feature do
  def input_valid_age_and_height
    select "18-25", from: "user[age_range]"
    find("#user_feet_tall").set(5)

    click_button "Next"
  end

  before do
    visit onboarding_step3_path
  end

  it "form validates presense of age range" do
    click_button "Next"

    expect(page).to have_content("can't be blank")
  end

  it "form does not validate presense of weight" do
    input_valid_age_and_height

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
    input_valid_age_and_height

    expect(current_path).to eq(onboarding_step4_path)

    visit onboarding_step3_path
    expect(page).to have_field("Feet", with: 5)
  end

  it "back button takes user back to previous step" do
    click_link "Back"

    expect(current_path).to eq(onboarding_step2_path)
  end

  it "form does not save the user in the db after successful submit" do
    input_valid_age_and_height

    expect(current_path).to eq(onboarding_step4_path)
    expect(User.last).to eq(nil)
  end

  it "preserves user's spot (next unfilled step of wizard)" do
    input_valid_age_and_height

    visit root_path
    expect(page).to have_text("Favorite Color")
  end
end
