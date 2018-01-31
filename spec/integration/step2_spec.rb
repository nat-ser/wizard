require 'rails_helper'

describe "second page", type: :feature do

  before do
    visit onboarding_step2_path
  end

  it "form validates presense of email" do
    click_button "Next"

    expect(page).to have_content("can't be blank")
  end

  it "form validates the format of the email" do
    fill_in "Email", with: "dancer"
    click_button "Next"

    expect(page).to have_content("is invalid")
  end

  it "form can be submitted succesfully navigating user to next page" do
    # fill_in "First Name", with: "Napolean"
    fill_in "Email", with: "dancer.numberone@gmail.com"
    click_button "Next"

    expect(current_path).to eq(onboarding_step3_path)
  end

  it "back button takes user back to previous step" do
    click_button "Back"

    expect(current_path).to eq(onboarding_step1_path)
  end

  it "correctly-filled form submits and remembers info on return" do
    fill_in "Email", with: "dancer.numberone@gmail.com"
    click_button "Next"

    expect(current_path).to eq(onboarding_step3_path)


    visit onboarding_step2_path
    expect(find_field("Email").value).to eq("dancer.numberone@gmail.com")
  end
end
