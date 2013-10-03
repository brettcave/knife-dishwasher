# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "knife-dishwasher"
  s.version = "0.0.1"
  s.summary = "Node and Client Clean Up Tool"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.author = "Stephen Coetzee"
  s.description = "Tool for cleaning unused chef clients and nodes."
  s.email = "sacoetzee@gmail.com"
  s.homepage = 'https://github.com/stephencoetzee/knife-diskwasher'
  s.files = Dir["lib/**/*"]
  s.rubygems_version = "1.6.2"
  s.license = "Apache 2.0"
  s.add_dependency "chef", "~> 11"
end
