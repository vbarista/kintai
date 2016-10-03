class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.text :title
      t.text :content

      t.timestamps null: false
    end
  end
end
