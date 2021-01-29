class CreateCompany < ActiveRecord::Migration[6.1]
  def change
    create_table :company do |t|
      t.string :name
      t.string :description
      t.string :country
      t.string :image
      t.integer :parent_id
    end
  end
end
