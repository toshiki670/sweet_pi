require "sweet_pi/version"
require "sweet_pi/runner"
require "thor"

module SweetPi
  class Error < StandardError; end
  # Your code goes here...


  def self.a
    SweetPi::Runner.start(["-v"])
  end

end

