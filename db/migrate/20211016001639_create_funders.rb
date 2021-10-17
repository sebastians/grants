class CreateFunders < ActiveRecord::Migration[6.1]
  def change
    create_table :funders do |t|
      t.integer :ein
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end
