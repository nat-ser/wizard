# frozen_string_literal: true

class OnboardingController < ApplicationController
  def step1
    @user = User.new(session[:user])
  end

  def step2
    @user = User.new(user_params)
    if @user.valid?(:step1)
      session[:user] = user_params
    else
      render :step1
    end
  end

  def step3
  end

  def step4
  end

  def thanks
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name)
  end
end
