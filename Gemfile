source 'https://rubygems.org'

unless File.exist?('haml4')
  system('rake haml4') # for travis
end

if ENV.key?('HAML_PATH')
  gem 'haml', path: ENV['HAML_PATH']
else
  gem 'haml', '5.0.0.beta.2'
end
gem 'haml4', path: 'haml4'
gem 'hamlit'
gem 'faml'
gem 'slim', git: 'https://github.com/slim-template/slim'

gem 'benchmark-ips'
gem 'pry'
gem 'rake'
