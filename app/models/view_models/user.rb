module ViewModels
  class User < SimpleDelegator
    def self.decorate(user)
      new user
    end

    # user has a favorite color and it's not one of the select options
    def display_prefilled_custom_color_form?
      fave_color.present? && !default_color_options.include?(fave_color)
    end

    def default_color_options
      ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Other"]
    end

  end
end
