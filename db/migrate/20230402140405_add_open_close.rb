class AddOpenClose < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :open_close_hours, :jsonb, default: {
      monday: { open: '9:00', close: '17:00' },
      tuesday: { open: '9:00', close: '17:00' },
      wednesday: { open: '9:00', close: '17:00' },
      thursday: { open: '9:00', close: '17:00' },
      friday: { open: '9:00', close: '17:00' },
      saturday: { open: 'closed', close: 'closed' },
      sunday: { open: 'closed', close: 'closed' }
    }
  end
end
