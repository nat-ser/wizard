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

class User < ApplicationRecord
  validates :first_name, :last_name, presence: true, on: :step1
  validates :email, presence: true, on: :step2
  validates :email,
            format: {
              with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i
            },
            on: :step2

  validates :age_range, :feet_tall, presence: true, on: :step3
  validates :feet_tall, :inches_tall, numericality: { only_integer: true }, allow_blank: true, on: :step3
  validates :weight_in_lb, numericality: { only_integer: true }, allow_blank: true, on: :step3
  validates :fave_color, presence: true, on: :step4
  # for the final encompassing validation at the end
  validates :first_name,
            :last_name,
            :email,
            :age_range,
            :feet_tall,
            presence: true,
            on: :create

  def height_in_inches
    @height_in_inches ||= feet_tall * 12 + inches_tall.presence
  end

  def height_string_feet_and_inches
    @height_string_feet_and_inches ||= "#{feet_tall}'#{inches_tall}\""
  end
end
