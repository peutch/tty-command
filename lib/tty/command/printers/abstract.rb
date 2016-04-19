# encoding: utf-8

require 'pastel'

module TTY
  class Command
    module Printers
      class Abstract
        extend Forwardable

        def_delegators :@color, :decorate

        attr_reader :output

        # Initialize a Printer object
        #
        # @param [IO] output
        #   the printer output
        #
        # @api public
        def initialize(output, options = {})
          @output = output
          enabled = options.fetch(:color) { true }
          @color  = ::Pastel.new(output: output, enabled: enabled)
        end

        def print_command_start(cmd)
          write(cmd.to_command)
        end

        def print_command_out_data(cmd, *args)
          write(args.join)
        end

        def print_command_err_data(cmd, *args)
          write(args.join)
        end

        def print_command_exit(cmd, *args)
          write(args.join)
        end

        def write(message)
          raise NotImplemented, "Abstract printer cannot be used"
        end
      end # Abstract
    end # Printers
  end # Command
end # TTY