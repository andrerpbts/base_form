# frozen_string_literal: true

require 'rails_helper'

module BaseForm
  RSpec.describe Form do
    describe '#persisted?' do
      let(:dummy) { Dummy.new(the_dumbass: the_dumbass) }

      before do
        class Dummy < BaseForm::Form
          use_form_records :dumbass

          attribute :the_dumbass

          def persist
            @dumbass ||= the_dumbass
          end
        end

        dummy.save
      end

      subject { dummy.persisted? }

      context 'when dummy is saved normally' do
        let(:the_dumbass) do
          double :the_dumbass, errors: []
        end

        it { is_expected.to be_truthy }
      end

      context 'when dummy is not saved normally' do
        let(:the_dumbass) do
          double :the_dumbass, errors: [{ attribute: 'foo', error: 'bar' }]
        end

        it { is_expected.to be_falsey }
      end
    end

    describe '#persist' do
      let(:wrong_dummy) { WrongDummy.new }

      before do
        class WrongDummy < BaseForm::Form; end
      end

      subject { wrong_dummy.save }

      it { expect { subject }.to raise_error(NotImplementedError) }
    end

    describe '.save' do
      let(:params) { { foo: 'bar' } }
      let(:save) { double :save, save: true }

      before do
        allow(described_class).to receive(:new)
          .with(params)
          .and_return(save)
      end

      subject { described_class.save(params) }

      it 'calls the save method as static method' do
        expect(save).to receive(:save)

        subject
      end
    end
  end
end
