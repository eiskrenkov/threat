# frozen_string_literal: true

# This plugin runs Ribocop and warns about found violations
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
class Threat::Plugins::Rubocop < Danger::Plugin
  def run!
    files_to_lint = git.modified_files + git.added_files

    result = `bundle exec rubocop --force-exclusion --format json #{files_to_lint.join(' ')}`
    return if $CHILD_STATUS.exitstatus.zero?

    json_result = JSON.parse(result)

    json_result['files'].each do |file|
      file_path = file['path']

      file['offenses'].each do |offence|
        line = offence.dig('location', 'line')

        warn("Rubocop: #{offence['message']} at #{file_path}:#{line}")
      end
    end
  end
end
