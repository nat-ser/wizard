module ViewModels
  class Wizard
    def self.steps
      %w[step1 step2 step3 step4 thanks].freeze
    end

    def self.next_step(current_step)
      steps[steps.index(current_step) + 1] || step1
    end
  end
end
