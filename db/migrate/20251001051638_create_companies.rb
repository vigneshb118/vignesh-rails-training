class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies, id: :uuid do |t|
      t.string :name
      t.text :description
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
