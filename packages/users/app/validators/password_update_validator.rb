class PasswordUpdateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _value)
    return if record.provider == 'email'

    record.errors.add(attribute, 'not possible to modify password if logging from provider')
  end
end
