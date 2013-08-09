# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dragonfly-openssl/version"

Gem::Specification.new do |s|
  s.name        = "dragonfly-openssl"
  s.version     = Dragonfly::OpenSSL::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Wagner Amaral"]
  s.email       = ["wamaral@wamaral.org"]
  s.homepage    = "https://github.com/wamaral/dragonfly-openssl"
  s.summary     = %q{Dragonfly wrapper for openssl executable}
  s.description = %q{Dragonfly wrapper for openssl executable}

  s.rubyforge_project = "dragonfly-openssl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'dragonfly', '>= 0.9'
  s.add_dependency 'rake', '>= 0.9.2'
end
