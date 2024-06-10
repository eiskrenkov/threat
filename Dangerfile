# frozen_string_literal: true

require 'threat'

# This way we're autoloading all defined plugins for Danger to register
Threat.loader.eager_load_namespace(Threat::Plugins)

refresh_plugins

ENVIRONMENT_MAPPING = {
  Danger::RequestSources::LocalOnly => 'local',
  Danger::RequestSources::GitHub => 'github'
}.freeze

# This is a simple way to run a plugins only when the Dangerfile is executed in a specific environment
#
# P.S This method is added to the top-level scope of your Dangerfile
def on(environment_name)
  return unless ENVIRONMENT_MAPPING[env.request_source.class] == environment_name.to_s

  yield
end

# This is a simple way to run only a part of your Dangerfile
#
# P.S This method is added to the top-level scope of your Dangerfile
def workflow(workflow_name)
  return if (current_workflow = ENV['DANGER_WORKFLOW']) &&
            (workflow_name.to_s != current_workflow)

  yield
end

def rake(*tasks)
  system("bundle exec rake #{tasks.join(' ')}")
end
