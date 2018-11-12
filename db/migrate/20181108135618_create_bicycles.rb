class CreateBicycles < ActiveRecord::Migration[5.2]
  def change
    create_table :bicycles do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.integer :bicycle_type

      t.timestamps
    end
  end
end
