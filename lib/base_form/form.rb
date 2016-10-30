module BaseForm
  class Form
    include ActiveModel::Model
    include Virtus.model

    class << self
      attr_reader :form_records

      protected

      def use_form_records(*records)
        attr_reader(*records)

        @form_records = records
      end
    end

    def self.save(*params)
      new(*params).save
    end

    def save
      perform_in_transaction { persist } if valid?

      self
    end

    def valid?
      errors.empty? && super
    end

    def persisted?
      @persisted
    end

    protected

    def persist
      raise NotImplementedError
    end

    def perform_in_transaction
      ActiveRecord::Base.transaction do
        yield if block_given?

        records_errors.each { |error| add_errors_for(error) }
        raise ActiveRecord::Rollback if errors.any?

        @persisted = true
      end
    end

    def records_errors
      self.class.form_records.map do |form_record|
        send(form_record).try(:errors)
      end.compact.flatten
    end

    def add_errors_for(error)
      error.each do |attribute, message|
        errors.add attribute, message
      end
    end
  end
end
