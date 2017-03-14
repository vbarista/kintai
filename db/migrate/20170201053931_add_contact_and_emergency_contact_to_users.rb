class AddContactAndEmergencyContactToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact, :string
    add_column :users, :emergency_contact, :string
  end
end
