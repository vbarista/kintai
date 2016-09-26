class CreateTimeSettings < ActiveRecord::Migration
  def change
    create_table :time_settings do |t|
      t.integer :company_id
      t.string  :base
      t.string  :work_s, limit: 5
      t.string  :work_e, limit: 5
      t.string  :rest_first_s,  limit: 5
      t.string  :rest_first_e,  limit: 5
      t.string  :rest_second_s, limit: 5
      t.string  :rest_second_e, limit: 5
      t.string  :rest_therd_s,  limit: 5
      t.string  :rest_therd_e,  limit: 5
      t.string  :rest_fourth_s, limit: 5
      t.string  :rest_fourth_e, limit: 5
      t.string  :rest_fifth_s,  limit: 5
      t.string  :rest_fifth_e,  limit: 5
      t.string  :rest_sixth_s,  limit: 5
      t.string  :rest_sixth_e,  limit: 5
      t.timestamps null: false
    end

    add_index :time_settings, :company_id, unique: true
  end
end
