# frozen_string_literal: true

class OnboardingController < ApplicationController
  before_action :user, :step_count

  def step1
  end

  def step2
  end

  def step3
  end

  def step4
  end

  def thanks
  end

  def validate_step
    @user = User.new(user_params)
    if @user.valid?(current_step)
      session[:user] = user_params
      @step_count += 1
      redirect_to action: current_step
    else
      render current_step
    end
  end

  private
  def user
    @user = User.new(session[:user])
  end

  def step_count
    @step_count ||= 1
  end

  # def increment_current_step
  #   binding.pry
  #   @step_count += 1
  # end

  def current_step
    case step_count
      when 1
        :step1
      when 2
        :step2
      when 3
        :step3
      when 4
        :step4
    end
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email)
  end
end
