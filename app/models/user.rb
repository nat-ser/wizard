# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  first_name       :string
#  last_name        :string
#  email            :string
#  age_range        :string
#  height_in_inches :integer
#  weight_in_lb     :integer
#  fave_color       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ApplicationRecord
  validates :first_name, :last_name, presence: true, on: :step1
  validates :email, presence: true, on: :step2
  validates :email,
            format: {
              with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i
            },
            on: :step2

  validates :age_range, :height_in_inches, presence: true, on: :step3
  validates :height_in_inches, numericality: { only_integer: true }, on: :step3
  validates :weight_in_lb, numericality: { only_integer: true }, on: :step3
  validates :fave_color, presence: true, on: :step4

  # for the final encompassing validation at the end
  validates :first_name,
            :last_name,
            :email,
            :age_range,
            :height_in_inches,
            :fave_color,
            presence: true,
            on: :create

  def derive_height_in_inches(feet, inches)
    @height_in_inches = feet * 12 + inches
  end

end
