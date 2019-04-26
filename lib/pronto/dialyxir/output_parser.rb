module Pronto
  module Dialyxir
    class OutputParser
      attr_reader :output, :file

      def initialize(file, output)
        @file = file
        @output = output
      end

      def parse
        return {} if output.to_s.empty?

        if output.lines[2].start_with?("== Compilation error")
          return [{
                    line: 0,
                    column: nil,
                    level: :error,
                    message: output.chomp("\n")
                  }]
        end

        output.split(%r{_{80}}).map do |message|
          message = message.lstrip
          path_parts = message.lines.first.split(':')
          next unless file.start_with?(path_parts[0])
          text = message.lines.drop(1).join()
          next if text.nil?
          text = text.gsub("_", "\_").gsub(":", "\:").gsub("@", "\@")
          {
            line: path_parts[1].to_i,
            column: nil,
            level: :warning,
            message: text.chomp("\n")
          }
        end.compact
      end
    end
  end
end
