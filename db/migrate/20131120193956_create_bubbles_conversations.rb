class CreateBubblesConversations < ActiveRecord::Migration
  def change
    create_table :bubbles_conversations do |t|

      t.timestamps
    end
  end
end
