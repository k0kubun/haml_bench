require 'benchmark/ips'
require 'haml'
require 'haml4'
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

  Haml::Engine.new(haml_code, format: :html5, ugly: true, escape_html: true).def_method(context, :run_haml)
  Haml4::Engine.new(haml_code, format: :html5, ugly: true, escape_html: true).def_method(context, :run_haml4)
  context.instance_eval %Q[
    def run_hamlit; #{Hamlit::Engine.new.call(haml_code)}; end
  ]

  x.report("haml #{Haml::VERSION}")     { context.run_haml }
  x.report("haml #{Haml4::VERSION}")    { context.run_haml4 }
  x.report("hamlit #{Hamlit::VERSION}") { context.run_hamlit }
  x.compare!
end
