class CreateRiskMitigationActions < ActiveRecord::Migration[7.2]
  def change
    create_table :risk_mitigation_actions do |t|
      t.references :risk,        null: false, foreign_key: true
      t.references :assigned_to, null: true,  foreign_key: { to_table: :users }
      t.references :issue,       null: true,  foreign_key: true
      t.string :title,       null: false
      t.text   :description
      t.string :action_type, null: false, default: 'reduce_probability'
      t.string :status,      null: false, default: 'open'
      t.date   :due_date
      t.timestamps null: false
    end
  end
end
