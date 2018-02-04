class StepConstraint
  def initialize(step)
    @step = step
  end

  def matches?(request)
    request.session["step_url"] == "/onboarding/#{@step}"
  end
end
