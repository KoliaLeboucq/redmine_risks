class CreateRiskReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :risk_reviews do |t|
      t.references :risk,   null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.integer :probability, null: false
      t.integer :impact,      null: false
      t.text    :comment
      t.text    :decision
      t.datetime :reviewed_at, null: false
      t.timestamps null: false
    end
  end
end
