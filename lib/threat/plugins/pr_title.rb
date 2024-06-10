# frozen_string_literal: true

# This plugin validates that the PR title includes JIRA ticket number and a meaningful title
#
# Usage:
#
# Dangerfile
#
# ```ruby
# danger.import_dangerfile(gem: 'threat')
#
# pr_title.run!
# ```
#
class Threat::Plugins::PrTitle < Danger::Plugin
  JIRA_TICKET_NUMBER_FORMAT = '[A-Z]+-\d+(?:, [A-Z]+-\d+)*'         # [KEY-123]
  PR_TITLE_REGEX = /\[#{JIRA_TICKET_NUMBER_FORMAT}\] [A-Z|0-9].*\S/ # [KEY-123] An amazing feature

  def run!
    # This check is available for GitHub pull requests only
    return unless env.request_source.instance_of?(Danger::RequestSources::GitHub) &&
                  env.pr?

    failure('Invalid format of PR title') unless github.pr_title.strip.match?(PR_TITLE_REGEX)
  end
end
