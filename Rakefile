file :haml4 do
  system("git clone --branch stable --depth=1 https://github.com/haml/haml haml4")
  Dir.chdir('haml4') do
    `git grep --name-only "require \\('\\|\\"\\)haml"`.split("\n").each do |file|
      src = File.read(file)
      src.gsub!(/require ("|')haml/, 'require \1haml4')
      File.write(file, src)
    end

    `git grep --name-only Haml`.split("\n").each do |file|
      src = File.read(file)
      src.gsub!('Haml', 'Haml4')
      File.write(file, src)
    end

    %w[haml.gemspec].each do |file|
      src = File.read(file)
      src.gsub!("'haml'", "'haml4'")
      File.write(file, src)
    end

    {
      'haml.gemspec' => 'haml4.gemspec',
      'lib/haml.rb'  => 'lib/haml4.rb',
      'lib/haml'     => 'lib/haml4',
    }.each do |from, to|
      system("mv #{from} #{to}")
    end
  end
end
