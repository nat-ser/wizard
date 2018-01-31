# frozen_string_literal: true

class OnboardingController < ApplicationController
  before_action :user
  def thanks
  end

  def validate_step
    @user = User.new(user_params)
    if @user.valid?(current_step.to_sym)
      session[:user] = user_params
      redirect_to action: next_step
    else
      render current_step
    end
  end

  private

  def user
    @user = User.new(session[:user])
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email)
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
