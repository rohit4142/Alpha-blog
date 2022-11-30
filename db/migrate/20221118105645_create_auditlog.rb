class CreateAuditlog < ActiveRecord::Migration[7.0]
  def change
    create_table :auditlogs do |t|
      t.integer :user_id
      t.integer :article_id
      t.string :message_log
      t.timestamps
    end
  end
end
