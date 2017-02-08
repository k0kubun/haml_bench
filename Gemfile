source 'https://rubygems.org'

unless File.exist?('haml4')
  system('rake haml4') # for travis
end

if ENV.key?('HAML_PATH')
  gem 'haml', path: ENV['HAML_PATH']
else
  gem 'haml', git: 'https://github.com/haml/haml'
end
gem 'haml4', path: 'haml4'
gem 'hamlit'
gem 'faml'
gem 'slim'

gem 'benchmark-ips'
gem 'pry'
gem 'rake'
