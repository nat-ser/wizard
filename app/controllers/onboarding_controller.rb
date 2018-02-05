# frozen_string_literal: true

class OnboardingController < ApplicationController
  before_action :wizard_user_from_session, except: [ :thanks ]
  before_action only: [ :step3, :step4 ] { decorate_user(@wizard_user) }
  before_action except: [ :valid]

  def validate_step
    user = User.new(user_params)
    decorate_user(user)
    if user.valid?(current_step.to_sym)
      user_params.each { |p, v| session["user"][p] = v }
      remember_place
      redirect_to action: ViewModels::Wizard.next_step(current_step)
    else
      @wizard_user = user
      render current_step
    end
  end

  def create
    user = User.new(user_params)
    decorate_user(user)
    if user.valid?(current_step.to_sym)
      user_params.each { |p, v| session["user"][p] = v }
      validate_entire_user
    else
      @wizard_user = user
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

  def remember_place
    session["step_url"] = {} if session["step_url"].nil?
    session["step_url"] = "/onboarding/" + ViewModels::Wizard.next_step(current_step).to_s
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
end
