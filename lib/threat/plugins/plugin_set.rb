# frozen_string_literal: true

class Threat::Plugins::PluginSet < Danger::Plugin
  def rails_lint
    rubocop.run!
    todo.run!
  end
end
