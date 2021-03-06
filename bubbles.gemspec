$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bubbles/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bubbles"
  s.version     = Bubbles::VERSION
  s.authors     = ["Michal Szyndel"]
  s.email       = ["msz@sent.com"]
  s.homepage    = "https://github.com/hajder/bubbles"
  s.summary     = "Simple Rails messaging engine"
  s.description = "Simple Rails messaging engine"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
