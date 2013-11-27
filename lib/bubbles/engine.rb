module Bubbles
  class Engine < ::Rails::Engine
    isolate_namespace Bubbles
  end
  
  # module Namespaced
  #   def self.table_name_prefix
  #     'bubbles_'
  #   end
  # end
end
