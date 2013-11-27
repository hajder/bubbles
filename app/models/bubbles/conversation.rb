module Bubbles
  class Conversation < ActiveRecord::Base
    has_many :conversation_members
    has_many :members, through: :conversation_members
    has_many :messages, autosave: true
    
    validate :conversation_has_at_least_two_members

    scope :read, -> { where(ConversationMember.table_name => {unread: false}) }
    scope :unread, -> { where(ConversationMember.table_name => {unread: true}) }
    
    def mark_as_read!(member)
      self.conversation_members.where(member_id: member.id).first.update unread: false
    end
    
    def conversation_has_at_least_two_members
      if members.size < 2
        errors.add :base, "should have at least two members"
      end
    end
    protected :conversation_has_at_least_two_members
  end
end
