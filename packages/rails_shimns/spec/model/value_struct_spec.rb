require 'rails_helper'

class ValueStructClass < ValueStruct
  attributes do
    name String
  end
end

RSpec.describe ValueStruct do
  describe '.coerce_date' do
    it 'parses a date string' do
      value = '2022-03-02'
      actual = described_class.coerce_date(value)
      expect(actual).to eq(Date.new(2022, 3, 2))
    end

    it 'returns the string if the value cannot be parsed' do
      value = 'not a date'
      actual = described_class.coerce_date(value)
      expect(actual).to eq(value)
    end

    it 'returns nil for nil' do
      actual = described_class.coerce_date(nil)
      expect(actual).to be_nil
    end
  end

  describe '.coerce_time' do
    it 'parses a time string' do
      value = '2022-03-02T16:34:22Z'
      actual = described_class.coerce_time(value)
      expect(actual).to eq(Time.utc(2022, 3, 2, 16, 34, 22))
    end

    it 'returns the string if the value cannot be parsed' do
      value = 'no time information'
      actual = described_class.coerce_time(value)
      expect(actual).to eq(value)
    end

    it 'returns nil for nil' do
      actual = described_class.coerce_time(nil)
      expect(actual).to be_nil
    end
  end

  describe '.coerce_string' do
    it 'converts an integer to a string' do
      actual = described_class.coerce_string(1)
      expect(actual).to eq('1')
    end
  end

  describe '.try_new' do
    it 'returns success when the value struct is successfully instantiated' do
      result = ValueStructClass.try_new(name: 'Vanguard')

      expect(result).to be_success
      expect(result.error).to be_nil
      expect(result.value).to eq(ValueStructClass.new(name: 'Vanguard'))
    end

    it 'returns error when a required attribute is missing' do
      result = ValueStructClass.try_new

      expect(result).not_to be_success
      expect(result.value).to be_nil
      expect(result.error).to eq('Some attributes required by `ValueStructClass` are missing: `name`')
    end

    it 'returns error when an attribute has the wrong type' do
      result = ValueStructClass.try_new(name: 1)

      expect(result).not_to be_success
      expect(result.value).to be_nil
      expect(result.error).to eq("Some attributes of `ValueStructClass` are invalid:\n  - name: 1\n")
    end
  end
end
