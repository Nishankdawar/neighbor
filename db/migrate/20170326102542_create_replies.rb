class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.references :clack, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
