# frozen_string_literal: true

# Add to_integer helper to False Class
class FalseClass; def to_i = 0; end
# Add to_integer helper to True Class
class TrueClass; def to_i = 1; end
