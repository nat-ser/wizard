# frozen_string_literal: true

require "rails_helper"

describe User do
  context "with all required attributes" do
    it "is created successfully" do
      user = User.create(first_name: "nat",
                         last_name: "seryakova",
                         email: "nat@mail.com",
                         age: 14,
                         height_in_inches: 72,
                         fave_color: "butterfly yellow")
      expect(user.reload.first_name).to eq("nat")
    end
  end

  context "with missing required attributes" do
    it "is not created" do
      user = User.create(first_name: "nat",
                         last_name: "seryakova",
                         email: "nat@mail.com")
      expect(user.valid?).to eq(false)
    end
  end
end
