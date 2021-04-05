lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sakamichi_scraper/version"

Gem::Specification.new do |spec|
  spec.name          = "sakamichi_scraper"
  spec.version       = SakamichiScraper::VERSION
  spec.authors       = ["oyrarumakan"]
  spec.email         = ["ryo19911030@hotmail.co.jp"]

  spec.summary       = "scrape gem from Sakamichi group's(Hinatazaka46, Sakurazaka46) blog"
  spec.description   = "This gem is used to scrape info from Sakamichi group's(Hinatazaka46, Sakurazaka46) blog."
  spec.homepage      = "https://github.com/oyrarumakan/sakamichi_scraper"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r(^exe/)) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "6.0.3.4"
  spec.add_dependency "nokogiri", "1.10.10"
  spec.add_development_dependency "bundler", "2.1.4"
  spec.add_development_dependency "pry", "0.13.1"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "1.11.0"
end
