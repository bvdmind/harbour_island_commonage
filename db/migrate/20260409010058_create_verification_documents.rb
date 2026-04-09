class CreateVerificationDocuments < ActiveRecord::Migration[8.1]
  def change
    create_table :verification_documents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :document_type
      t.text :notes

      t.timestamps
    end
  end
end
