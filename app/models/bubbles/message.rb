module Bubbles
  class Message < ActiveRecord::Base
    belongs_to :conversation
    belongs_to :sender, class_name: Bubbles.messagable_type
    
    validates_presence_of :sender, :body
    validates_presence_of :conversation
    validate :sender_is_member_of_conversation
    
    after_save :mark_as_unread
    
    default_scope -> { self.order(created_at: :asc) }
    
    def sender_is_member_of_conversation
      if conversation.present? && !self.conversation.members.include?(sender)
        errors.add(:base, 'sender is not a member of conversation')
      end
    end
    protected :sender_is_member_of_conversation
    
    def mark_as_unread
      self.conversation.conversation_members.where.not(member_id: self.sender_id).update_all unread: true
    end
    protected :mark_as_unread
  end
end
