# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  first_name   :string
#  last_name    :string
#  email        :string
#  age_range    :string
#  weight_in_lb :integer
#  fave_color   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  feet_tall    :integer
#  inches_tall  :integer
#

require "rails_helper"

describe User do
  context "with all required attributes" do
    it "is created successfully" do
      user = User.create(first_name: "nat",
                         last_name: "seryakova",
                         email: "nat@mail.com",
                         age_range: "18-25",
                         feet_tall: 3,
                         fave_color: "butterfly yellow")
      expect(user.reload.first_name).to eq("nat")
    end
  end

  context "with missing required attributes" do
    it "is not created" do
      user = User.create(first_name: "nat",
                         last_name: "seryakova",
                         email: "nat@mail.com",
                         age_range: "18-25")
      expect(user.valid?).to eq(false)
    end
  end
end
