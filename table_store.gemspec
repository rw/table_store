# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'table_store/version'

Gem::Specification.new do |gem|
  gem.name          = "table_store"
  gem.version       = TableStore::VERSION
  gem.authors       = ["rw"]
  gem.email         = ["me@rwinslow.com"]
  gem.description   = %q{Tabular in-memory data structure.}
  gem.summary       = %q{In-memory tables that use sorted hashes to provide relational access.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
