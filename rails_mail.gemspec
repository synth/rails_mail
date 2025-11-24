require_relative "lib/rails_mail/version"

Gem::Specification.new do |spec|
  spec.name        = "rails_mail"
  spec.version     = RailsMail::VERSION
  spec.authors     = [ "Peter Philips" ]
  spec.email       = [ "pete@p373.net" ]
  spec.homepage    = "https://github.com/synth/rails_mail"
  spec.summary     = "Database-backed Action Mailer delivery method with web interface"
  spec.description = "A Rails engine that provides a database-backed delivery method for Action Mailer, primarily intended for local development and staging environments. It captures emails sent through your Rails application and provides a web interface to view them."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/synth/rails_mail"
  spec.metadata["changelog_uri"] = "https://github.com/synth/rails_mail/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7", "< 9"
  spec.add_dependency "nokogiri", ">= 1.14", "< 2.0"
  spec.add_dependency "pagy", "~> 43"

  spec.add_development_dependency "debug", ">= 1.0.0"
end
