# frozen_string_literal: true

Rails.application.routes.draw do
  get "/thanks", to: "onboarding#thanks"
  get "/onboarding/step1", to: "onboarding#step1"
  get "/onboarding/step2", to: "onboarding#step2"
  get "/onboarding/step3", to: "onboarding#step3"
  get "/onboarding/step4", to: "onboarding#step4"

  root to: "onboarding#step2",
    constraints: StepConstraint.new("step2")

  root to: "onboarding#step3",
    constraints: StepConstraint.new("step3")

  root to: "onboarding#step4",
    constraints: StepConstraint.new("step4")

  root to: "onboarding#step1"

  post "/create", to: "onboarding#create"
  post "/validate_step", to: "onboarding#validate_step"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
