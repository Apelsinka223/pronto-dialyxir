require 'open3'


module Pronto
  module Dialyxir
    class Wrapper
      def initialize
        @stdout = run_linter
      end

      def lint(patch)
        return [] if patch.nil?
        path = patch.delta.new_file[:path]
        return {} if @stdout.nil? || @stdout == 0
        OutputParser.new(path, @stdout).parse
      end

      private

      def run_linter
        _, stderr, _ = Open3.capture3(dialyxir_executable)
        stderr
      end

      def dialyxir_executable
        "mix dialyzer --quiet --ignore-exit-status"
      end
    end
  end
end
