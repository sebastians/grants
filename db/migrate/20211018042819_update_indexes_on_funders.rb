class UpdateIndexesOnFunders < ActiveRecord::Migration[6.1]
  def change
    remove_index :funders, :ein

    add_index :funders, :ein
    add_index :funders, [:ein, :type], unique: true
  end
end
