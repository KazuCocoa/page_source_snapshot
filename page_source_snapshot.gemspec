# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'page_source_snapshot/version'

Gem::Specification.new do |spec|
  spec.name          = "page_source_snapshot"
  spec.version       = PageSourceSnapshot::VERSION
  spec.authors       = ["Kazuaki MATSUO"]
  spec.email         = ["fly.49.89.over@gmail.com"]

  spec.summary       = %q{Get diff for two xml sources}
  spec.description   = %q{Get diff for two xml sources}
  spec.homepage      = "https://github.com/KazuCocoa/page_source_snapshot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "oga", "~> 2.14"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
