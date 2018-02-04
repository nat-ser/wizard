# frozen_string_literal: true

require "rails_helper"

describe "fourth page", type: :feature, js: true do
  def successfully_complete_flow
    # 1
    visit onboarding_step1_path
    fill_in "First name", with: "Napolean"
    fill_in "Last name", with: "Dynamite"
    click_button "Next"

    # 2
    fill_in "Email", with: "dancer.numberone@gmail.com"
    click_button "Next"

    # 3
    select "18-25", from: "user[age_range]"
    find("#user_feet_tall").set(5)

    click_button "Next"

    # 4
    select "Red", from: "user[fave_color]"
    click_button "Finish"
  end

  before do
    visit onboarding_step4_path
  end

  it "form validates presense of favorite color" do
    click_button "Finish"

    expect(page).to have_content("can't be blank")
    select "Other", from: "user[fave_color]"
    expect(page).to have_content("Please review the problems below:")
  end

  it "form submits successfully with a custom option only if previous required fields have been filled" do
    select "Other", from: "user[fave_color]"
    find(".color-text").set("special snowflake white")
    click_button "Finish"
    expect(page).to have_content("Please review the problems below:")

    successfully_complete_flow

    expect(current_path).to eq(thanks_path)
    expect(page).to have_content("Good job")
    expect(User.last.valid?).to eq(true)
    expect(User.last.first_name).to eq("Napolean")
  end

  it "correctly-filled form remembers info on return" do
    select "Red", from: "user[fave_color]"
    click_button "Finish"

    visit onboarding_step3_path
    visit onboarding_step4_path
    expect(find_field("user[fave_color]").value).to eq("Red")
  end

  it "correctly-filled form displays custom input on return correctly" do
    select "Other", from: "user[fave_color]"
        # save_and_open_page

    find(".color-text").set("special snowflake white")
    click_button "Finish"
    save_and_open_page
    visit onboarding_step3_path
    visit onboarding_step4_path

    expect(find_field("user[fave_color]").value).to eq("special snowflake white")
  end


  it "back button takes user back to previous step" do
    click_link "Back"

    expect(current_path).to eq(onboarding_step3_path)
  end
end
