# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/dialyxir/version'

Gem::Specification.new do |spec|
  spec.name          = 'pronto-dialyxir'
  spec.version       = Pronto::Dialyxir::VERSION
  spec.authors       = ['Anastasiya Dyachenko']
  spec.email         = ['apelsinka223@gmail.com']

  spec.summary       = 'Pronto runner for Dialyxir'
  spec.homepage      = 'https://github.com/Apelsinka223/pronto-dialyxir'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3'

  spec.add_runtime_dependency 'pronto', '~> 0.7', '> 0.7.0'
end
