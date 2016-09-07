class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.integer :company_id
      t.integer :user_id
      t.string :year
      t.string :month
      t.string :memo

      t.string :required_work_day
      t.string :total_work_day
      t.string :required_work_hour
      t.string :allowance_hour
      t.string :absence
      t.string :holiday_work
      t.string :home
      t.string :paid_holiday
      t.string :house_work
      t.string :bereavement
      t.string :transfer
      t.string :business_trip
      t.string :drill
      t.string :special
      t.string :total_hour_working
      t.string :total_hour_house
      t.string :total_hour_late_early

      t.timestamps null: false
    end
    add_index :rosters, :company_id
    add_index :rosters, :user_id
    add_index :rosters, [:company_id, :user_id]
  end
end
