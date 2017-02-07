require 'pry'
require 'haml'

haml_code = File.read("#{__dir__}/templates/slim_bench.haml")

buffer_options = { ugly: true, escape_html: true }
if Haml::Options.respond_to?(:buffer_defaults)
  Haml::Options.buffer_defaults.merge!(buffer_options)
end
haml_src = Haml::Engine.new(haml_code, buffer_options.merge(format: :html5)).compiler.precompiled_with_ambles([])

puts Pry.Code(haml_src).highlighted
