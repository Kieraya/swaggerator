
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "swaggerator/version"

Gem::Specification.new do |spec|
  spec.name          = "swaggerator"
  spec.version       = Swaggerator::VERSION
  spec.authors       = ["Somesh Mukherjee"]
  spec.email         = ["mail@somesh.info"]

  spec.summary       = %q{Swaggerator generates a swagger file for your rails project by scanning your code for specific pattersns}
  spec.description   = %q{ Swaggerator parses your routes file and enhances the information by scanning your source code for specific patterns. }
  spec.homepage      = "https://somesh.io"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "tty-spinner"
  spec.add_dependency "terminal-table"
  spec.add_dependency 'tty-table'
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "activesupport"
end
