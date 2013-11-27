class CreateBubblesMessages < ActiveRecord::Migration
  def change
    create_table :bubbles_messages do |t|
      t.belongs_to :conversation
      t.integer :sender_id
      t.text :body

      t.timestamps
    end
  end
end
