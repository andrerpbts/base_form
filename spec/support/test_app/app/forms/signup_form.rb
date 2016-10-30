class SignupForm < BaseForm::Form
  use_form_records :account, :user

  attribute :email
  attribute :password
  attribute :password_confirmation
  attribute :plan, Plan, default: proc { Plan.default }

  validates :plan, presence: true

  private

  def persist
    @account ||= Account.create plan: plan
    @user ||= account.users.create user_params
  end

  def user_params
    {
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      account_owner: true
    }
  end
end
