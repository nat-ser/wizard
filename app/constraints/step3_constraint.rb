class Step3Constraint
  def matches?(request)
    request.session["step_url"] == "/onboarding/step3"
  end
end
