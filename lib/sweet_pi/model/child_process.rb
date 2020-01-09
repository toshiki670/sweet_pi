# frozen_string_literal: true

module SweetPi
  class ChildProcess

    def initialize(*argv, &block)
      @status_read, @status_write = IO.pipe
      @value_read, @value_write = IO.pipe

      child_fork(*argv, block)
    end

    def value
      Process.waitpid @pid
      Marshal.load(@value_read)
    end

    private

    def child_fork(*argv, block)
      @pid = Process.fork do
        @value_read.close

        status = :run
        Marshal.dump(status, @status_write)

        result = block.call(*argv)

        status = false
      rescue => e
        raise e
        status = nil
        result = nil
      ensure
        Marshal.dump(status, @status_write)
        Marshal.dump(result, @value_write)
      end
    end

  end
end
