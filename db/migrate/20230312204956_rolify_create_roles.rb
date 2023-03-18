class RolifyCreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table(:roles, id: false) do |t|
      t.string :id, null: false, primary_key: true
      t.string :name
      t.references :resource, :polymorphic => true, type: :string

      t.timestamps
    end

    create_table(:users_roles, :id => false) do |t|
      t.string :user_record_id, :null => false, foreign_key: { to_table: :users }
      t.references :role, type: :string
    end
    
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_roles, [ :user_record_id, :role_id ])
  end
end
