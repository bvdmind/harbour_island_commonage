class AddIsVerifiedToDocuments < ActiveRecord::Migration[8.1]
  def change
    add_column :documents, :is_verified, :boolean, default: false, null: false
  end
end
