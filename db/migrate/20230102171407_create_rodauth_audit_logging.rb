class CreateRodauthAuditLogging < ActiveRecord::Migration[7.0]
  def change
    # Used by the audit logging feature
    create_table :account_authentication_audit_logs do |t|
      t.references :account, foreign_key: true, null: false
      t.datetime :at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.text :message, null: false
      t.jsonb :metadata
      t.index [:account_id, :at], name: "audit_account_at_idx"
      t.index :at, name: "audit_at_idx"
    end
  end
end
