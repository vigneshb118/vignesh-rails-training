class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :title
      t.text :description
      t.integer :job_type
      t.integer :salary
      t.references :company, type: :uuid, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
