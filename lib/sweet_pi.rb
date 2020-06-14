# frozen_string_literal: true

require 'sweet_pi/version'
require 'sweet_pi/runner'
require 'sweet_pi/pi'
require 'sweet_pi/generator'

require 'bigdecimal'
require 'bigdecimal/util'

module SweetPi
  class << self
    def generator(process_size)
      SweetPi::Generator.new(process_size)
    end
  end
end
