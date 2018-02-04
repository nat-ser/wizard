# frozen_string_literal: true

require "rails_helper"

describe "fourth page", type: :feature, js: true do

  def input_valid_custom_color
    select "Other", from: "user[fave_color]"

    fill_in 'user[fave_color]', with: "special snowflake white"
    click_button "Finish"
  end

  def input_valid_selected_color
    select "Red", from: "user[fave_color]"
    click_button "Finish"
  end

  def complete_1_to_3
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
  end

  before do
    visit onboarding_step4_path
  end

  it "form validates presense of favorite color" do
    click_button "Finish"

    expect(page).to have_content("can't be blank")
    select "Other", from: "user[fave_color]"
    click_button "Finish"

    expect(page).to have_content("Please review the problems below:")
    expect(page).to have_content("can't be blank")
  end

  it "form submits successfully with a custom option only if previous required fields have been filled" do
    input_valid_custom_color
    expect(page).to have_content("First name can't be blank")
    complete_1_to_3

    expect(find(".color-text input").value).to eq("special snowflake white")
    click_button "Finish"

    expect(current_path).to eq(thanks_path)
    expect(page).to have_content("Good job")
  end

  it "form saves the user if all required attrs are filled out" do
    complete_1_to_3
    input_valid_custom_color

    expect(current_path).to eq(thanks_path)
    expect(User.last.valid?).to eq(true)
    expect(User.last.first_name).to eq("Napolean")
  end

  it "correctly-filled form remembers info on return" do
    input_valid_selected_color

    visit onboarding_step3_path
    visit onboarding_step4_path
    expect(find_field("user[fave_color]").value).to eq("Red")
  end

  it "correctly-filled form displays custom input on return correctly" do
    input_valid_custom_color

    visit onboarding_step3_path
    visit onboarding_step4_path

    expect(find(".color-text input").value).to eq("special snowflake white")
  end


  it "back button takes user back to previous step" do
    click_link "Back"

    expect(current_path).to eq(onboarding_step3_path)
  end
end
