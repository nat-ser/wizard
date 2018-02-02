# frozen_string_literal: true

class OnboardingController < ApplicationController
  before_action :session_user, except: [ :thanks ]
  def thanks
  end


  def validate_step
    # params = @session_user.attributes.merge(user_params.to_h)
    # @user_with_all_remembered_fields  = User.new(params)
    @user = User.new(user_params)
    if @user.valid?(current_step.to_sym)
      user_params.each { |p, v| session["user"][p] = v }
      redirect_to action: next_step
    else
      @session_user = @user
      render current_step
    end
  end

  def create
    @user = User.new(user_params)
    if @user.valid?(current_step.to_sym)
      user_params.each { |p, v| session["user"][p] = v }
      validate_entire_user
    else
      @session_user = @user
      render current_step
    end
  end

  private

  def validate_entire_user
    # validate session user here because it encompasses all of the attrs
    if @session_user.save(context: :create)
      reset_session
      flash[:success] = "Good job"
      redirect_to thanks_url
    else
      flash.now[:error] = @session_user.errors.full_messages.join(" / ")
      render current_step
    end
  end

  def session_user
    session["user"] = {} if session["user"].nil?
    @session_user = User.new(session["user"])
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :age_range, :feet_tall, :inches_tall, :weight_in_lb, :fave_color)
  end

  def steps
    %w[step1 step2 step3 step4 thanks]
  end

  def current_step
    params["current_step"]
  end

  def next_step
    steps[steps.index(current_step) + 1] || step1
  end
end
