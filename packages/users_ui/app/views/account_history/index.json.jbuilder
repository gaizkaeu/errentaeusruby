# frozen_string_literal: true

json.array! @actions, partial: 'account_history/log', as: :action
