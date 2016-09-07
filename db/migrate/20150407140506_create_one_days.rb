class CreateOneDays < ActiveRecord::Migration
  def change
    create_table :one_days do |t|
      t.integer :roster_id
      t.integer :company_id
      t.string  :situation
      t.date    :day
      t.string  :from,          limit: 5
      t.string  :to,            limit: 5
      t.float   :working_hours, scale: 2
      t.string  :late_early,    limit: 5
      t.string  :house,         limit: 5
      t.string  :note,          limit: 256

      t.timestamps null: false
    end
    add_index :one_days, :roster_id
  end
end
