# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  first_name       :string
#  last_name        :string
#  email            :string
#  age              :integer
#  height_in_inches :integer
#  weight_in_lb     :integer
#  fave_color       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ApplicationRecord
  validates :first_name, :last_name, presence: true, on: :step1
  validates :email, presence: true, on: :step2
  validates :age, :height, presence: true, on: :step3
  validates :fave_color presence: true, on: :step4
end
