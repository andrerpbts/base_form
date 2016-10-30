require 'spec_helper'

module BaseForm
  RSpec.describe Form do
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
