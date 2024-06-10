# frozen_string_literal: true

# macOS and Raycast (https://www.raycast.com/) are required to celebrate a good run with confetti
#
# Usage:
#
# Dangerfile
#
# ```ruby
# danger.import_dangerfile(gem: 'threat')
#
# # The rest of your Dangerfile goes here...
#
# confetti.run! unless failed?
# ```
#
class Threat::Plugins::Confetti < Danger::Plugin
  DEEPLINK = 'raycast://confetti'

  def run!
    return unless RUBY_PLATFORM =~ /darwin/

    system("open #{DEEPLINK}", err: File::NULL)
  end
end
