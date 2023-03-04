class Repositories::RepositoryBase
  include Pagy::Backend

  def filter(filter_params)
    pagy(self.class.model_name.filter(filter_params, self.class.query_base.all), items: 20, page: 1)
  end

  class << self
    def query_base
      model_name
    end

    def filter(filter_params)
      res = model_name.filter(filter_params, query_base { |query| yield query if block_given? })
      res.map do |record|
        map_record(record)
      end
    end

    def find_by!(**kargs)
      res = query_base.find_by!(**kargs)
      map_record(res)
    end

    def find(id)
      res =
        if block_given?
          yield query_base
        else
          query_base.find(id)
        end
      map_record(res)
    end

    def map_record(record)
      if block_given?
        yield record
      else
        model_mapping_name.new(record.attributes.symbolize_keys!)
      end
    end

    def last
      res = query_base.last
      map_record(res)
    end

    def first
      res = query_base.first
      map_record(res)
    end

    delegate :count, to: :query_base

    def where(**kargs)
      query_base.where(**kargs).map do |record|
        map_record(record)
      end
    end

    def add(record, raise_error: false)
      create_method = raise_error ? :create! : :create
      res = model_name.public_send(create_method, record.to_hash)
      record = map_record(res)
      record.instance_variable_set(:@errors, res.errors)
      record
    end

    def update(id, attributes, raise_error: false)
      update_method = raise_error ? :update! : :update
      target_record = model_name.find(id)
      target_record.public_send(update_method, attributes)
      target_record.reload
      record = map_record(target_record)
      record.instance_variable_set(:@errors, target_record.errors)
      record
    end

    def model_name
      "#{base_name}Record".constantize
    end

    def model_mapping_name
      base_name.to_s.constantize
    end

    private

    def base_name
      base_name = name.gsub(/Repository$/, '')
      base_name.gsub(/Repositories::/, '')
    end
  end
end
