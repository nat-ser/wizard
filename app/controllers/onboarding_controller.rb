# frozen_string_literal: true

class OnboardingController < ApplicationController
  def step1
    @user = User.new(session[:user])
  end

  def step2
    @user = User.new(session[:user])
  end

  def step3
  end

  def step4
  end

  def thanks
  end

  def validate_step
    @user = User.new(user_params)
    if @user.valid?(:step1)
      session[:user] = user_params
      redirect_to onboarding_step2_url
    else
      render :step1
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email)
  end
end
