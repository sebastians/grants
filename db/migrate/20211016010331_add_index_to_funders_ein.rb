class AddIndexToFundersEin < ActiveRecord::Migration[6.1]
  def change
    add_index :funders, :ein, unique: true
  end
end
