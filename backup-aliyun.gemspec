# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name          = "backup-aliyun"
  s.version       = "0.1.1"
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Jason Lee"]
  s.email         = ["huacnlee@gmail.com"]
  s.homepage      = "https://github.com/huacnlee/backup-aliyun"
  s.summary       = %q{Aliyun OSS Storage support for Backup}
  s.description   = %q{Aliyun OSS Storage support for Backup}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.license       = 'MIT'

  s.add_dependency "backup", ">= 4.2.2"
  s.add_dependency "carrierwave-aliyun", ["~> 0.3.0"]
end
