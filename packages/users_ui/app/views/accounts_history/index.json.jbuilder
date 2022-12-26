# frozen_string_literal: true

json.array! @actions, partial: 'accounts/log', as: :action
