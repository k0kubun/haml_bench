source 'https://rubygems.org'

unless File.exist?('haml4')
  system('rake haml4') # for travis
end

if ENV.key?('HAML_PATH')
  gem 'haml', path: ENV['HAML_PATH']
else
  gem 'haml', git: 'https://github.com/haml/haml', ref: 'ed361008151d14c1168a7804f7f2a0d4a414e423'
end
gem 'haml4', path: 'haml4'
gem 'hamlit'
gem 'faml'
gem 'slim', git: 'https://github.com/slim-template/slim'
gem 'erubi', git: 'https://github.com/jeremyevans/erubi'

gem 'benchmark-ips'
gem 'pry'
gem 'rake'
