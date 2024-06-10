# frozen_string_literal: true

require 'English'

# This plugin runs RSpec and reports failing examples
#
# Usage:
#
# Dangerfile
#
# ```ruby
# danger.import_dangerfile(gem: 'threat')
#
# rspec.run!
# ```
#
class Threat::Plugins::Rspec < Danger::Plugin
  FAILING_SPECS_LOG = 'tmp/failing_specs.log'
  SEPARATOR = ':'

  def run!
    `bundle exec rspec -f failures --out #{FAILING_SPECS_LOG}`
    return if $CHILD_STATUS.exitstatus.zero?

    File.readlines(FAILING_SPECS_LOG).each do |line|
      file_path, line_number, example = line.split(SEPARATOR)

      failure("Example #{example.strip} failed at #{file_path.delete_prefix('./')}:#{line_number}")
    end
  end
end
