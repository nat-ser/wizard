# README

##### Configuration
* Ruby version - 2.4.2
* Rails version - Rails 5.1.4

#### Run Locally
- `git clone git@github.com:nat-ser/wizard.git`
- `bundle`
- `rake db:create`
- `rake db:migrate`
- `rails s`

#### Test Suite
- `rspec`

#### Notes
- User can jump around to different steps
- My app assumes that if user submitted last step without completing other steps, his place returns to the beginning

- In the `OnBoardingController.rb`, I define `@wizard_user`, `@view_user`, and `current_step_user`
These are the distinctions:

#### @wizard_user
- a user instance containing all gathered data thus far from the session

#### @view_user
- an instance of ViewModels::User, which inherits all user methods to clean up views

#### current_step_user
- a user instance initialized from the current step before validations run. If the validations pass, the current_step_user attributes are stored in the session


#### What needs work:
- OnboardingController a little bloated -> I can maybe handle the user in various states by using `wicked` gem next time
- Hardcoded value in views for current_step, next route, and back route -> Instead, can use remembered last step completed from session
- Add error handling outside of few nil checks and validation errors
- Javascript is hacky `step4.js` -> ideally I would remake the form to accept separate parameters for selected or custom color instead of trying to fit inside Railsy conventions


[Application URL](https://magical-form.herokuapp.com/)
