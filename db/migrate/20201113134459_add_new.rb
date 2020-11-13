class AddNew < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :article_id, :integer
    add_index :authors, :article_id
  end
end
