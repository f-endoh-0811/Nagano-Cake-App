class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      
      t.string :name,       null: false
      t.text :introduction, null: false
      t.integer :price,     null: false
      t.boolean :status,    null: false, default: "TRUE"
      
      t.timestamps
    end
  end
end
