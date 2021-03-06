require 'benchmark/ips'
require 'haml4'
require 'haml'
require 'faml'
require 'hamlit'
require 'slim'
require 'erubi'

class Context
  def header
    'Colors'
  end

  def item
    [ { name: 'red',   current: true,  url: '#red'   },
      { name: 'green', current: false, url: '#green' },
      { name: 'blue',  current: false, url: '#blue'  } ]
  end
end

Benchmark.ips do |x|
  haml_path = "#{__dir__}/#{ARGV.first || 'templates/slim_bench.haml'}"
  puts "Rendering: #{haml_path}"

  haml_code = File.read(haml_path)
  context = Context.new

  buffer_options = { escape_html: true }
  if Haml::Options.respond_to?(:buffer_defaults)
    Haml::Options.buffer_defaults.merge!(buffer_options)
  end
  Haml::Engine.new(haml_code, buffer_options.merge(format: :html5)).def_method(context, :run_haml)
  Haml4::Engine.new(haml_code, format: :html5, ugly: true, escape_html: true).def_method(context, :run_haml4)
  context.instance_eval %Q[
    def run_faml; #{Faml::Engine.new.call(haml_code)}; end
    def run_hamlit; #{Hamlit::Engine.new.call(haml_code)}; end
  ]

  slim_path = haml_path.sub(/\.haml\z/, '.slim')
  slim_available = File.exist?(slim_path)
  if slim_available
    slim_code = File.read(slim_path)
    context.instance_eval("def run_slim; #{Slim::Engine.new.call(slim_code)}; end")
  end

  erb_path = haml_path.sub(/\.haml\z/, '.erb')
  erb_available = File.exist?(erb_path)
  if erb_available
    erb_code = File.read(erb_path)
    context.instance_eval("def run_erubi; #{Erubi::Engine.new(erb_code).src}; end")
  end

  x.report("haml #{Haml4::VERSION}")      { context.run_haml4 }
  x.report("haml #{Haml::VERSION}")       { context.run_haml }
  if ENV['BENCH_ALL'] == '1'
    x.report("faml #{Faml::VERSION}")     { context.run_faml }
    x.report("hamlit #{Hamlit::VERSION}") { context.run_hamlit }
    if slim_available
      x.report("slim #{Slim::VERSION}")   { context.run_slim }
    end
    if erb_available
      x.report('erubi 1.5.0') { context.run_erubi }
    end
  end
  x.compare!
end
