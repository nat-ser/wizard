# frozen_string_literal: true

module ViewModels
  class User < SimpleDelegator
    def self.decorate(user)
      new user
    end

    # user has a favorite color and it's not one of the select options
    def submitted_custom_fave_color?
      fave_color.present? && !color_options.include?(fave_color)
    end

    def color_options
      %w[Red Orange Yellow Green Blue Purple Other]
    end

    def age_options
      ["17 or younger", "18-25", "26-35", "36-45", "46 or older"]
    end
  end
end
