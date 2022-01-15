# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'erbh'
  spec.version       = '0.2.0'
  spec.authors       = ['Genki Sugawara']
  spec.email         = ['sugawara@winebarrel.jp']

  spec.summary       = 'Simple ERB helper.'
  spec.description   = 'Simple ERB helper.'
  spec.homepage      = 'https://github.com/winebarrel/erbh'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '1.24.1'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
