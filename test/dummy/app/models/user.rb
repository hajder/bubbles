class User < ActiveRecord::Base
  include Bubbles
  
  def to_s
    self.username
  end
end
