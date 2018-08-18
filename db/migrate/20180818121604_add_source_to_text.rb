class AddSourceToText < ActiveRecord::Migration[5.2]
  def change
    add_column :texts, :source, :text
  end
end
