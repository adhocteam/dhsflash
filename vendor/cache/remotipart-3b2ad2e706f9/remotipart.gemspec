# -*- encoding: utf-8 -*-
# stub: remotipart 1.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "remotipart"
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Greg Leppert", "Steve Schwartz"]
  s.date = "2013-07-08"
  s.description = "Remotipart is a Ruby on Rails gem enabling remote multipart forms (AJAX style file uploads) with jquery-rails.\n    This gem augments the native Rails 3 jQuery-UJS remote form function enabling asynchronous file uploads with little to no modification to your application.\n    "
  s.email = ["greg@formasfunction.com", "steve@alfajango.com"]
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = [".document", "CONTRIBUTING.md", "Gemfile", "Gemfile.lock", "History.rdoc", "LICENSE", "README.rdoc", "Rakefile", "VERSION_COMPATIBILITY.rdoc", "lib/generators/remotipart/install/install_generator.rb", "lib/remotipart.rb", "lib/remotipart/middleware.rb", "lib/remotipart/rails.rb", "lib/remotipart/rails/engine.rb", "lib/remotipart/rails/railtie.rb", "lib/remotipart/rails/version.rb", "lib/remotipart/render_overrides.rb", "lib/remotipart/request_helper.rb", "lib/remotipart/view_helper.rb", "remotipart.gemspec", "vendor/assets/javascripts/jquery.iframe-transport.js", "vendor/assets/javascripts/jquery.remotipart.js"]
  s.homepage = "http://opensource.alfajango.com/remotipart/"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Remotipart is a Ruby on Rails gem enabling remote multipart forms (AJAX style file uploads) with jquery-rails."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end