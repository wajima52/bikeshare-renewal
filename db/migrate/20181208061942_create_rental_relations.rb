class CreateRentalRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_relations do |t|
      t.references :bicycle    , foreign_key: true
      t.references :borrow_user, foreign_key: {to_table: :users}
      t.integer :answer, default: 0

      t.timestamps

      t.index [:bicycle_id, :borrow_user_id], unique: true
    end
  end
end
