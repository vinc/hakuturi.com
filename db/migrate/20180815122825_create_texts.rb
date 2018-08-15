class CreateTexts < ActiveRecord::Migration[5.2]
  def change
    create_table :texts do |t|
      t.string :title
      t.string :author
      t.text :body
      t.date :published_on

      t.timestamps
    end
  end
end
