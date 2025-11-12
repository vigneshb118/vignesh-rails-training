class CreateJobApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :job_applications, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :job, null: false, foreign_key: true, type: :uuid
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
