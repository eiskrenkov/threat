# frozen_string_literal: true

require_relative 'lib/threat/version'

Gem::Specification.new do |spec|
  spec.name     = 'threat'
  spec.version  = Threat::VERSION

  spec.authors  = ['Egor Iskrenkov']
  spec.email    = ['egor@iskrenkov.me']

  spec.summary  = 'Collection of useful Danger plugins'
  spec.homepage = 'https://github.com/eiskrenkov/threat'

  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata = {
    'source_code_uri' => spec.homepage
  }

  spec.files         = Dir['README.md', 'Dangerfile', 'lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'zeitwerk', '~> 2.5'

  spec.add_runtime_dependency 'danger', '9.4.3'
end
