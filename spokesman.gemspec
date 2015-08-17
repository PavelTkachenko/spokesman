# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spokesman/version'

Gem::Specification.new do |spec|
  spec.name          = 'spokesman'
  spec.version       = Spokesman::VERSION
  spec.authors       = ['Pavel Tkachenko']
  spec.email         = ['tpepost@gmail.com']

  spec.summary       = %q{ Flexible work with SMS. Best SMSC wrapper. }
  spec.homepage      = 'https://github.com/PavelTkachenko/spokesman'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',    '~> 1.10'
  spec.add_development_dependency 'rake',       '~> 10.0'
  spec.add_development_dependency 'rspec',      '~> 3.3'
  spec.add_development_dependency 'json_spec',  '~> 1.1'
end
