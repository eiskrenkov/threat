# frozen_string_literal: true

require 'zeitwerk'
require 'danger'

loader = Zeitwerk::Loader.for_gem
loader.setup
loader.eager_load_namespace(Threat::Plugins) # This way we're autoloading all defined plugins for Danger to register

module Threat
end
