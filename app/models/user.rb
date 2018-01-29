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
  validates :first_name, :last_name, :email, :age, :height_in_inches, :fave_color, presence: true
end
