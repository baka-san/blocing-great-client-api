Gem::Specification.new do |s|
  s.name          = 'blocing_great_client'
  s.version       = '0.0.1'
  s.date          = '2018-01-29'
  s.summary       = 'Blocing Great Client API'
  s.description   = 'A client for the Bloc API'
  s.authors       = ['Grant Backes']
  s.email         = 'gsbackes@gmail.com'
  s.files         = ['lib/blocing_great_client.rb']
  s.require_paths = ["lib"]
  s.homepage      =
    'http://rubygems.org/gems/blocing_great_client'
  s.license       = 'MIT'
  s.add_runtime_dependency 'httparty', '~> 0.13'
end