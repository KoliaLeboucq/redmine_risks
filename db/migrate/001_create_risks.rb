class CreateRisks < ActiveRecord::Migration[7.2]
  def change
    create_table :risks do |t|
      t.references :project,     null: false, foreign_key: true
      t.references :author,      null: false, foreign_key: { to_table: :users }
      t.references :assigned_to, null: true,  foreign_key: { to_table: :users }
      t.string  :title,          null: false
      t.text    :description
      t.text    :cause
      t.text    :consequence
      t.string  :category,       null: false, default: 'threat'
      t.string  :status,         null: false, default: 'open'
      t.date    :review_date
      t.integer :initial_probability, null: false, default: 3
      t.integer :initial_impact,      null: false, default: 3
      t.integer :current_probability, null: false, default: 3
      t.integer :current_impact,      null: false, default: 3
      t.timestamps null: false
    end

    add_index :risks, [:project_id, :status]
  end
end
