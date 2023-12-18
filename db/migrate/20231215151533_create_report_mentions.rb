class CreateReportMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :report_mentions do |t|
      t.references :mention_to, null: false, foreign_key: { to_table: 'reports' }
      t.references :mention_from, null: false, foreign_key: { to_table: 'reports' }
      t.index [:mention_to_id, :mention_from_id], unique: true

      t.timestamps
    end
  end
end
