class ArrayLengthValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value.try(:length) == options[:is]
      record.errors[attribute] << "is not of length #{options[:is]}."
    end
  end

end
