require 'rails_helper'

describe "second page", type: :feature do

  before do
    visit onboarding_step2_path
  end

  it "form validates presense of email" do
    click_button "Next"

    expect(current_path).to eq("/step2")
    expect(page).to have_content("can't be blank")
  end

  it "form validates the format of the email" do
    fill_in "Email", with: "dancer"
    click_button "Next"

    expect(page).to have_content("Please enter a valid email")
  end

  it "form can be submitted succesfully navigating user to next page" do
    # fill_in "First Name", with: "Napolean"
    fill_in "Email", with: "dancer.numberone@gmail.com"
    click_button "Next"

    expect(current_path).to eq("/step3")
  end

  it "back button take user back to previous step" do
    click_button "Back"

    expect(current_path).to eq("/step1")
  end
end
