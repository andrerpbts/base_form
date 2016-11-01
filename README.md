# BaseForm
[![Code Climate](https://codeclimate.com/github/andrerpbts/base_form/badges/gpa.svg)](https://codeclimate.com/github/andrerpbts/base_form)
[![Test Coverage](https://codeclimate.com/github/andrerpbts/base_form/badges/coverage.svg)](https://codeclimate.com/github/andrerpbts/base_form/coverage)
[ ![Codeship Status for andrerpbts/base_form](https://app.codeship.com/projects/8d9be4e0-811f-0134-3da7-7e60ebb19227/status?branch=master)](https://app.codeship.com/projects/182157)

A simple and small Form Objects Rails plugin for ActiveRecord based projects.

## Why?
In a development day-to-day basis, we commonly are confronted with situations where we
need to save data in more than one database table, running it's own validations, and
the validations of the all context together. In most cases a Form Object is a perfect
solution to deliver those records in a fun and maintenable code.

Actually, there's a lot of another gems to do that, like the great
[reform](https://github.com/apotonick/reform) or
[activeform-rails](https://github.com/GCorbel/activeform-rails), which are a more complete
solution for this problem. But, if you are looking for something lighter, maybe this
gem could fit well for you.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'base_form'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install base_form
```

## Usage
Let's suppose you want to create a
signup form (you can check this example in the dummy app on this gem specs), with
receiving a user email, a user password, a user password confirmation, and a plan. In your
signup form, you need to create an account for this user, associate it to a entrance plan
if it's not given, and make this user as an owner of this recently created account. Of course,
in this case, a simple user model saving will not be sufficient to save all those data and
accomplish with the requested business logic. So, you go to the Form Objects way,
installs this gem, creates your Ruby class to handle all this logic:

```ruby
class SignupForm < BaseForm::Form

end
```

With this empty class created, the easy way to start may be adding the attributes expected
in this form, like:

```ruby
class SignupForm < BaseForm::Form
  attribute :email
  attribute :password
  attribute :password_confirmation
  attribute :plan, Plan, default: proc { Plan.default }
end
```

Note, if you don't specifies a Plan to this form, it will call a default value, which in
this case is calling a proc that will call a `default` method in `Plan` model and probably
this will return the default plan instance, fetched from the database or something like that.

Let's put some form specific validation here. For example, we don't want the Plan being forced
with an empty string for example:

```ruby
class SignupForm < BaseForm::Form
  # ... attributes, validations ...

  validates :plan, presence: true
end
```

Now you may be asking: What about email and password? Shouldn't they be validated as well?
Well, you could, in fact, add all validations in this form instead put it in your models,
but sometimes you don't have much control of that.
Then, I'm showing here the case that `User` model has those validations. Don't be mad ok? :)

The form validations are the first validations tha are performed before it try to persist
something here. If this validation fails, for an example, the persist method will not even
be called, and we're done with it. Otherwise, it wil try to persist your logic, which we'll
implement next.

Ok, now, you need to set the records that you will persist here.
In this case is the `:user` you want to save, and the `:account` you will want to associate
to this user. So, you add it there (I recommend you let this in the top of the class to make
it clear):

```ruby
class SignupForm < BaseForm::Form
  use_form_records :user, :account

  # ... attributes, validations ...
end
```

This line will automatically generate `attr_readers` to each record there, and will add these
symbols in an array called `form_records` in your class. To understand it better, let's talk
about the `persist` implementation itself.

By the rule, the `persist` method is obligatory, and not implementing it, will cause your form
raise a `NotImplementedError` when calling `save` to it.

All things written inside `persist` method will automatically run in a ActiveRecord transaction,
and if some record have its validation failed, this will perform a rollback and deliver the form
to you with those errors grouped through `errors` method, like any AR model you are already
familiar with.

Let me stop to talk and show you something we can call as implementation of this:

```ruby
class SignupForm < BaseForm::Form
  # form records, attributes, validations, whatever

  private # because isolation is still a necessary evil ;)

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
```

So, here is the thing: check the variables names I've associated there are the names of
form_records I've defined before. It tries to create an account setting a plan to it
and then tries to create a user associated to this brand new account.

This `form_records` will call each object associated here to check its errors,
and group it in `errors` object in your form itself in case of some validation fails.
If all is fine, the form instance is returned to you and you will be able to call
methods like `persisted?`, `account`, `user`, `valid?` and etc...

Are you still there? :D

Let's see this class complete?

```ruby
class SignupForm < BaseForm
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
```

Hmmm, this looks pretty nice!

I hope this helps someone in the same way it helped me. Thanks!

## Contributing
- Fork it
- Make your implementations
- Send me a pull request

Thank you!

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
