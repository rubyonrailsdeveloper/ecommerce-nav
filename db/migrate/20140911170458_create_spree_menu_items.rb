class CreateSpreeMenuItems < ActiveRecord::Migration
  def change
    create_table :spree_menu_items do |t|
      t.string :name, null: false
      t.string :url, default: nil, null: true
      t.string :item_class, default: nil, null: true
      t.string :item_id, default: nil, null: true
      t.string :item_target, default: nil, null: true
      t.integer :parent_id, default: nil, null: true
      t.integer :position, default: 0, null: false
      t.timestamps
    end
  end
end
