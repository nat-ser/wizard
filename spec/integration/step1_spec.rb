# frozen_string_literal: true

require "rails_helper"

describe "first page", type: :feature do
  def input_valid_names
    fill_in "First name", with: "Napolean"
    fill_in "Last name", with: "Dynamite"
    click_button "Next"
  end

  before do
    visit onboarding_step1_path
  end

  it "form validates presense of both first and last name" do
    fill_in "First name", with: "Napolean"
    click_button "Next"

    expect(page).to have_content("can't be blank")
  end

  it "correctly-filled form submits and remembers info on return" do
    input_valid_names
    expect(current_path).to eq(onboarding_step2_path)

    visit onboarding_step1_path
    expect(find_field("First name").value).to eq("Napolean")
  end

  it "form does not save the user in the db after successful submit" do
    input_valid_names

    expect(current_path).to eq(onboarding_step2_path)
    expect(User.last).to eq(nil)
  end
end
