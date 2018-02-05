# frozen_string_literal: true

class OnboardingController < ApplicationController
  before_action :wizard_user_from_session, except: [ :thanks ]
  before_action only: [ :step3, :step4 ] { decorate_user(@wizard_user) }

  def validate_step
    decorate_user(current_step_user)
    if current_step_user.valid?(current_step.to_sym)
      store_state_in_session
      store_place_in_session
      redirect_to action: ViewModels::Wizard.next_step(current_step)
    else
      @wizard_user = current_step_user
      render current_step
    end
  end

  def create
    decorate_user(current_step_user)
    if current_step_user.valid?(current_step.to_sym)
      store_state_in_session
      validate_entire_user
    else
      @wizard_user = current_step_user
      render current_step
    end
  end

  private

  def validate_entire_user
    # validate session user here because it encompasses all of the attrs
    if @wizard_user.save(context: :create)
      reset_session
      flash[:success] = "Good job"
      redirect_to thanks_url
    else
      flash[:error] = @wizard_user.errors.full_messages.join(" / ")
      redirect_to action: current_step
    end
  end

  def wizard_user_from_session
    session["user"] = {} if session["user"].nil?
    @wizard_user = User.new(session["user"])
  end

  def store_place_in_session
    session["step_url"] = {} if session["step_url"].nil?
    session["step_url"] = ViewModels::Wizard.next_step_path(current_step)
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :age_range, :feet_tall, :inches_tall, :weight_in_lb, :fave_color)
  end

  def current_step
    params["current_step"]
  end

  def decorate_user(current_user)
    @user = ViewModels::User.decorate(current_user)
  end

  def store_state_in_session
    user_params.each { |p, v| session["user"][p] = v }
  end

  def current_step_user
    @current_step_user ||= User.new(user_params)
  end
end
