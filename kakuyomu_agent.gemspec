
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kakuyomu_agent/version'

Gem::Specification.new do |spec|
  spec.name          = 'kakuyomu_agent'
  spec.version       = KakuyomuAgent::VERSION
  spec.authors       = ['Fuji Nakahara']
  spec.email         = ['fujinakahara2032@gmail.com']

  spec.summary       = 'Selenium script for Kakuyomu episode management'
  spec.homepage      = 'https://github.com/fuji-nakahara/kakuyomu_agent'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'selenium-webdriver', '~> 3.14'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'dotenv', '~> 2.5'
  spec.add_development_dependency 'meowcop'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
