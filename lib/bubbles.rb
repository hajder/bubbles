require "bubbles/engine"
require 'active_support/concern'

module Bubbles
  extend ActiveSupport::Concern
  
  included do
    has_many :conversation_members, foreign_key: 'member_id', class_name: '::Bubbles::ConversationMember'
    has_many :conversations, through: :conversation_members, class_name: '::Bubbles::Conversation'
  end
  
  def self.setup
    yield self
  end
  
  mattr_accessor :messagable_type
  @@messagable_type = '::User'
  
  mattr_accessor :current_sender
  @@current_sender = :current_user
end
