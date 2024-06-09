# frozen_string_literal: true

# This plugin searches for TODO comments in the codebase
#
# TODO: May be improved by posting different messages for cases when TODO was just introduced in current diff and when
# contributor just touched a file with existing TODO
#
# Usage:
#
# Dangerfile
#
# ```ruby
# danger.import_dangerfile(gem: 'threat')
#
# todo.run!
# ```
#
class Threat::Plugins::Todo < Danger::Plugin
  SUPPORTED_COMMENTS = [
    '#', # e.g Ruby/YAML/Dockerfile and so on
    '//' # e.g JS
  ].freeze
  TODO_COMMENENT_REGEX = /(^|\s)(#{SUPPORTED_COMMENTS.join('|')})\sTODO:\s/

  def run!
    (git.modified_files + git.added_files).each do |path|
      File.foreach(path) do |line|
        next unless line.match?(TODO_COMMENENT_REGEX)

        warn('TODO detected! The whole team will be greatful if you may resolve it <3')
      end
    end
  end
end
