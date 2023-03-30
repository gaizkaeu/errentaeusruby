ActsAsTaggableOn.remove_unused_tags = true

ActsAsTaggableOn::Tag.class_eval do
  define_singleton_method :ransackable_attributes do |_auth_object = nil|
    ['name']
  end
end
