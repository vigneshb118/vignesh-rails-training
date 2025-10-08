class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :job_type
      t.integer :salary
      t.references :company, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
