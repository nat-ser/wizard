class Step2Constraint
  def matches?(request)
    request.session["step_url"] == "/onboarding/step2"
  end
end
