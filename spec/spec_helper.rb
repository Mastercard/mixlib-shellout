$:.unshift File.expand_path("../../lib", __FILE__)
$:.unshift File.expand_path("../..", __FILE__)
require "mixlib/shellout"

require "tmpdir"
require "tempfile"
require "timeout"

# Load everything from spec/support
# Do not change the gsub.
Dir["spec/support/**/*.rb"].map { |f| f.gsub(/.rb$/, "") }.each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run focus: true
  config.filter_run_excluding external: true

  # Add jruby filters here
  config.filter_run_excluding windows_only: true unless windows?
  config.filter_run_excluding unix_only: true unless unix?
  config.filter_run_excluding requires_root: true unless root?
  config.filter_run_excluding ruby: DependencyProc.with(RUBY_VERSION)

  config.run_all_when_everything_filtered = true

  config.warnings = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
