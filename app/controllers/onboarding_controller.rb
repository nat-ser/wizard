# frozen_string_literal: true

class OnboardingController < ApplicationController
  before_action :session_user
  def thanks
  end


  def validate_step
    # params = @session_user.attributes.merge(user_params.to_h)
    # @user_with_all_remembered_fields  = User.new(params)
    @user = User.new(user_params)
    set_user_height if current_step == "step3"
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
    if @user.save(context: current_step.to_sym)
      reset_session
      flash[:success] = "Good job"
      redirect_to thanks_url
    else
      @session_user = @user
      render current_step
    end
  end

  private

  def session_user
    session["user"] = {} if session["user"].nil?
    @session_user = User.new(session["user"])
  end

  def set_user_height
    return unless params["feet"].present? || params["inches"].present?
    if params["feet"].is_a?(Integer) || params["feet"].is_a?(Integer)
      feet, inches = params["feet"].to_i, params["inches"].to_i
      @user.height_in_inches = @user.derive_height_in_inches(feet, inches)
    else
      @user.height_in_inches = "string"
    end
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :age_range, :height_in_inches, :weight_in_lb, :fave_color)
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
