# frozen_string_literal: true

module ApplicationHelper
  def anonymize_string(string)
    string.gsub(//)
  end
end
