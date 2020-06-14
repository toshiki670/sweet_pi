# frozen_string_literal: true

require 'thor'
require 'sweet_pi/version'
require 'sweet_pi/generator'

module SweetPi
  class Runner < Thor
    default_command :calc_pi

    desc 'calc', 'Calculate PI'
    option :digit, aliases: :d, type: :numeric, default: 2, desc: 'Number of digits in decimal part of PI.'
    option :process, aliases: :p, type: :numeric, default: 1, desc: 'CPU processes.'
    option :output, aliases: :o, type: :string, required: true, desc: 'Output destination.'
    option :result, aliases: :r, type: :string, desc: 'Output of Processing result. standard output if not setting.'
    def calc_pi
      pi = SweetPi::Generator.new

      pi.range(options[:digit]) if options[:digit]
      pi.process_count = options[:process] if options[:process]
    end

    map %w[--version -v] => :version
    desc '--version, -v', 'print the version'
    def version
      puts SweetPi::VERSION
    end
  end
end
