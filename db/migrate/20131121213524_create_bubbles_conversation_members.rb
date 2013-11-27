class CreateBubblesConversationMembers < ActiveRecord::Migration
  def change
    create_table :bubbles_conversation_members do |t|
      t.integer :conversation_id, index: true
      t.integer :member_id, index: true
      t.boolean :unread
      t.timestamps
    end
  end
end
