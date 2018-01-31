# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "onboarding#step1"
  post "/thanks", to: "onboarding#thanks"
  get "/onboarding/step1", to: "onboarding#step1"
  get "/onboarding/step2", to: "onboarding#step2"
  get "/onboarding/step3", to: "onboarding#step3"
  get "/onboarding/step4", to: "onboarding#step4"

  post "/validate_step", to: "onboarding#validate_step"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
