require 'thor'
require 'sweet_pi/version'

module SweetPi
  class Runner < Thor

    map %w[--version -v] => :__version

    desc "hello NAME", "say hello to NAME"
    def hello(name)
      puts "Hello #{name}"
    end

    desc "--version, -v", "print the version"
    def __version
      VERSION
    end

  end
end
