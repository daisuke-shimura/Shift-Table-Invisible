class AddIsVisibleToWeeks < ActiveRecord::Migration[6.1]
  def change
    add_column :weeks, :is_visible, :boolean, default: true, null: false
  end
end
