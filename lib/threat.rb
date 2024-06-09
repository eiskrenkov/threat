# frozen_string_literal: true

require 'zeitwerk'
require 'danger'

module Threat
  module_function

  def loader
    @loader ||= Zeitwerk::Loader.for_gem
  end
end

Threat.loader.setup
