module BaseForm
  # This class is the main core functionality, by being an inheritable
  # class, which controls the form attributes assignments, validations
  # and persisting.
  #
  # Basically you should create your own Form Object Class, and inherit
  # this class (BaseForm::Form). After that you should put all records
  # in the `@form_records` variable, through `use_form_records` class
  # method. In your `persist` method implementation, just create the
  # record objects associating it to each variable in `form_records.`
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

    # This method will make the tings happen. It'll try run validations
    # set in your form class, and if it passes, it'll run your persist
    # instructions in a block of ActiveRecord transaction. If some
    # record fails it's persistence/validation, then a rollback will be
    # raised, the form will return those errors grouped in it. Otherwise
    # everything is commited and `persisted?` method will return true.
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
