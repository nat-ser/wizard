class Step4Constraint
  def matches?(request)
    request.session["step_url"] == "/onboarding/step4"
  end
end
