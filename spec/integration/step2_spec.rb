# frozen_string_literal: true

require "rails_helper"

describe "second page", type: :feature do
  def input_valid_email
    fill_in "Email", with: "dancer.numberone@gmail.com"
    click_button "Next"
  end

  before do
    visit onboarding_step2_path
  end

  it "form validates presense of email" do
    click_button "Next"

    expect(page).to have_content("can't be blank")
  end

  it "form validates the format of the email" do
    fill_in "Email", with: "meow"
    click_button "Next"

    expect(page).to have_content("is invalid")
  end

  it "form can be submitted succesfully navigating user to next page" do
    input_valid_email

    expect(current_path).to eq(onboarding_step3_path)
  end

  it "back button takes user back to previous step" do
    click_link "Back"

    expect(current_path).to eq(onboarding_step1_path)
  end

  it "correctly-filled form submits and remembers info on return" do
    input_valid_email

    expect(current_path).to eq(onboarding_step3_path)

    visit onboarding_step2_path
    expect(find_field("Email").value).to eq("dancer.numberone@gmail.com")
  end

  it "form does not save the user in the db after successful submit" do
    input_valid_email

    expect(current_path).to eq(onboarding_step3_path)
    expect(User.last).to eq(nil)
  end

  it "preserves user's spot (next unfilled step of wizard)" do
    input_valid_email

    visit root_path
    expect(page).to have_text("Age")
  end
end
