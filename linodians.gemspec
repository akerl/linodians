require 'English'
$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'linodians/version'

Gem::Specification.new do |s|
  s.name        = 'linodians'
  s.version     = Linodians::VERSION
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.summary     = 'Parse Linode employees'
  s.description = 'Library for viewing public Linode employee data'
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/linodians'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split
  s.executables = ['linodians']

  s.add_dependency 'cymbal', '~> 2.0.0'
  s.add_dependency 'nokogiri', '~> 1.10.0'

  s.add_development_dependency 'codecov', '~> 0.1.1'
  s.add_development_dependency 'fuubar', '~> 2.5.0'
  s.add_development_dependency 'goodcop', '~> 0.8.0'
  s.add_development_dependency 'rake', '~> 13.0.0'
  s.add_development_dependency 'rspec', '~> 3.9.0'
  s.add_development_dependency 'rubocop', '~> 0.76.0'
  s.add_development_dependency 'vcr', '~> 5.0.0'
  s.add_development_dependency 'webmock', '~> 3.7.6'
end
