class CreateAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :awards do |t|
      t.integer :amount
      t.string :purpose

      t.timestamps
    end

    add_reference :awards, :funder, foreign_key: true
    add_reference :awards, :recipient, foreign_key: { to_table: :funders }
  end
end
