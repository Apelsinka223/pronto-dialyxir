require 'spec_helper'
require 'pathname'
require 'pronto/dialyxir/output_parser'

RSpec.describe Pronto::Dialyxir::OutputParser do
  let(:parser) { described_class.new(file, output) }
  let(:file) { 'lib/my_app/db.ex' }
  let(:output) { File.read("#{Pathname.pwd}/spec/fixtures/dialyxir_output.txt") }

  describe '#parse' do
    subject { parser.parse }
    it 'parses output' do
      expect(subject).to eq(
        [
          { line: 12,
            :column => nil,
            :level => :warning,
            :message =>
              %q(The @spec for the function does not match the success typing of the function.

Function:
Chat.Helpers.Checks.MACRO-id_empty?/2

Success typing:
@spec MACRO-id_empty?(_, _) ::
  {:or, [{:context, Chat.Helpers.Checks} | {:import, Kernel}, ...],
   [{:==, [any(), ...], [any(), ...]} | {:is_nil, [any(), ...], [any(), ...]}, ...]})
          },
          { line: 66,
            :column => nil,
            :level => :warning,
            :message => %q(The pattern can never match the type.

Pattern:
false

Type:
true)
          },
          { line: 93,
            :column => nil,
            :level => :warning,
            :message => %q(The pattern
_resolution, _

can never match since previous clauses completely cover the type
_, _)
          }
        ]
      )
    end
  end
end
