module Bubbles
  module ConversationsHelper
    def current_sender
      self.send Bubbles.current_sender.to_sym
    end
  end
end
