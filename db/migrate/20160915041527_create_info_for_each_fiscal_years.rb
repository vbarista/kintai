class CreateInfoForEachFiscalYears < ActiveRecord::Migration
  def change
    create_table :info_for_each_fiscal_years do |t|
      t.integer :company_id
      t.integer :user_id
      t.string :year
      t.string :carry_over_paid_leave_count
      t.string :carry_over_late_ealy

      t.timestamps null: false
    end
  end
end
