require 'benchmark/ips'
require 'haml4'
require 'haml'
require 'faml'
require 'hamlit'

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
  haml_code = File.read("#{__dir__}/templates/view.haml")
  context = Context.new

  Haml4::Engine.new(haml_code, format: :html5, ugly: true, escape_html: true).def_method(context, :run_haml4)
  Haml::Engine.new(haml_code, format: :html5, ugly: true, escape_html: true).def_method(context, :run_haml)
  context.instance_eval %Q[
    def run_faml; #{Faml::Engine.new.call(haml_code)}; end
    def run_hamlit; #{Hamlit::Engine.new.call(haml_code)}; end
  ]

  x.report("haml #{Haml4::VERSION}")    { context.run_haml4 }
  x.report("haml #{Haml::VERSION}")     { context.run_haml }
  if ENV['BENCH_ALL'] == '1'
    x.report("faml #{Faml::VERSION}")     { context.run_faml }
    x.report("hamlit #{Hamlit::VERSION}") { context.run_hamlit }
  end
end
