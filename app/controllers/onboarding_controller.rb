# frozen_string_literal: true

class OnboardingController < ApplicationController
  before_action :session_user
  def thanks
  end

  def validate_step
    params = @session_user.attributes.merge(user_params.to_h)
    @user_with_all_remembered_fields  = User.new(params)
    if current_step == "step3"
      set_user_height
    end
    if @user_with_all_remembered_fields .valid?(current_step.to_sym)
      session[:user] = @user_with_all_remembered_fields.attributes
      redirect_to action: next_step
    else
      render current_step
    end
  end

  private

  def session_user
    @session_user = User.new(session[:user])
  end

  def set_user_height
    feet, inches = params["feet"].to_i, params["inches"].to_i
    height = @user_with_all_remembered_fields.derive_height_in_inches(feet, inches)
    @user_with_all_remembered_fields.height_in_inches = height
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :age_range, :height_in_inches, :weight_in_lb)
  end

  def steps
    %w[step1 step2 step3 step4]
  end

  def current_step
    params["current_step"]
  end

  def next_step
    steps[steps.index(current_step) + 1]
  end
end
