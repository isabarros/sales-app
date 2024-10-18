class CreateSalesReps < ActiveRecord::Migration[7.0]
  def change
    create_table :sales_reps do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
