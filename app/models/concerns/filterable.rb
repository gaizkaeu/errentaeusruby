module Filterable
    extend ActiveSupport::Concern
  
    module ClassMethods
      
      # Call the class methods with names based on the keys in <tt>filtering_params</tt>
      # with their associated values. For example, "{ status: 'delayed' }" would call 
      # `filter_by_status('delayed')`. Most useful for calling named scopes from 
      # URL params. Make sure you don't pass stuff directly from the web without 
      # allowlist only the params you care about first!
      def filter(filtering_params, results)
        return results if filtering_params.nil?
        filtering_params.each do |key, value|
          results = results.public_send("filter_by_#{key}", value) if value.present?
        end
        results
      end
    end
  end