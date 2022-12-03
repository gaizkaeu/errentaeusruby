class RemoveClientLawyerFromDocuments < ActiveRecord::Migration[7.0]
  def change
    remove_column :documents, :client_id
    remove_column :documents, :lawyer_id
  end
end
