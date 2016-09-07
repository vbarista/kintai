class CreateDayOfWorkAndHolidays < ActiveRecord::Migration
  def change
    create_table :day_of_work_and_holidays do |t|
      t.integer :company_id
      t.integer :day_type
      t.string  :title
      t.date    :day
      t.timestamps null: false
    end

    add_index :day_of_work_and_holidays, [:company_id, :day]
  end
end
