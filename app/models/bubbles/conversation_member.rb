module Bubbles
  class ConversationMember < ActiveRecord::Base
    belongs_to :member, class_name: Bubbles.messagable_type
    belongs_to :conversation
  end
end
