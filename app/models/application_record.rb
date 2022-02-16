class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def max_length(attribute)
      length_validator(attribute).options[:maximum]
    end

    def length_validator(attribute)
      self.validators_on(attribute).detect do |validator|
        validator.is_a?(ActiveModel::Validations::LengthValidator)
      end
    end
  end
end
