Gem::Specification.new do |s| 
  s.platform  =   Gem::Platform::RUBY
  s.name      =   "scatter"
  s.version   =   "0.0.1"
  s.date      =   Date.today.strftime('%Y-%m-%d')
  s.author    =   "imedo GmbH"
  s.email     =   "entwicker@imedo.de"
  s.homepage  =   "http://www.imedo.de/"
  s.summary   =   "Gem deployment tool"
  s.files     =   Dir.glob("{bin,lib}/**/*")

  s.bindir = 'bin'
  s.executables = Dir['bin/*'].collect { |file| File.basename(file) }

  s.require_path = "lib"
end
