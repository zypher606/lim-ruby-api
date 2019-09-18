class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :content_type
      t.string :content_value
      t.references :webpage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
