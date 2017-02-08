source 'https://rubygems.org'

unless File.exist?('haml4')
  system('rake haml4') # for travis
end

if ENV.key?('HAML_PATH')
  gem 'haml', path: ENV['HAML_PATH']
else
  gem 'haml', git: 'https://github.com/haml/haml', ref: '70fa4acde89b5a9dd5146ff6f1adf6662d824e0b'
end
gem 'haml4', path: 'haml4'
gem 'faml'
gem 'hamlit'

gem 'benchmark-ips'
gem 'pry'
gem 'rake'
