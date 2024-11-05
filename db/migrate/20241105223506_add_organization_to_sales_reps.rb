class AddOrganizationToSalesReps < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales_reps, :organization, null: true, foreign_key: true
  end
end
