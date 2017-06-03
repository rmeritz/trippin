class CreatePoint < ActiveRecord::Migration[5.1]
  def change
    create_table :points do |t|
      t.timestamps
      t.belongs_to :trip, null: false
      t.float :lat, null: false
      t.float :long, null: false
      t.string :name
    end
  end
end
