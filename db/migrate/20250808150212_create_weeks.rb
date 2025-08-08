class CreateWeeks < ActiveRecord::Migration[6.1]
  def change
    create_table :weeks do |t|
      t.date "monday", null: false
      t.boolean "is_created", default: false, null: false
      t.timestamps
    end
  end
end
