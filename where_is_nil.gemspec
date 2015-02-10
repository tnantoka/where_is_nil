$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "where_is_nil/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "where_is_nil"
  s.version     = WhereIsNil::VERSION
  s.authors     = ["tnantoka"]
  s.email       = ["tnantoka@bornneet.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of WhereIsNil."
  s.description = "TODO: Description of WhereIsNil."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end
