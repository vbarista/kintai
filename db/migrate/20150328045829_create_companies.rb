class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :type
      t.string :name, null: false
      t.string :code, null: false

      t.timestamps null: false
    end
    add_index :companies, :type
    add_index :companies, :code, unique: true
  end
end
