# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SignupForm, type: :model do
  it { is_expected.to validate_presence_of(:plan) }
  it { is_expected.to respond_to(:account) }
  it { is_expected.to respond_to(:user) }

  describe '#save' do
    let!(:basic_plan) { create :plan, name: 'Basic' }
    let(:user) { build :user }

    subject { described_class.new email: user.email, password: user.password }

    before do
      subject.save
    end

    context 'correct registration' do
      it { expect(subject).to be_valid }
      it { expect(subject.errors).to be_empty }
      it { expect(subject.account).to be_valid }
      it { expect(subject.account.plan).not_to be_nil }
      it { expect(subject.user).to be_valid }
    end

    context 'incorrect registration' do
      subject { described_class.new email: nil, password: '1234' }

      it { expect(subject).not_to be_valid }
      it { expect(subject.errors).not_to be_empty }
      it { expect(subject.errors[:email]).to eq(['can\'t be blank']) }

      it 'validates the password lenght' do
        expect(subject.errors[:password])
          .to eq(['is too short (minimum is 8 characters)'])
      end
    end

    context 'existing user' do
      let(:user) { create :user }

      it { expect(subject).not_to be_valid }
      it { expect(subject.errors).not_to be_empty }
      it { expect(subject.errors[:email]).to eq(['has already been taken']) }
    end
  end
end
