class AddTypeToFunders < ActiveRecord::Migration[6.1]
  def change
    add_column :funders, :type, :string
  end
end
