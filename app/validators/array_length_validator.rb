class ArrayLengthValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value.try(:length) == options[:with]
      record.errors[attribute] << "is not of length #{options[:with]}."
    end
  end

end
