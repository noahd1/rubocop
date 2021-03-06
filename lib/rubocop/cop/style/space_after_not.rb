# encoding: utf-8

module Rubocop
  module Cop
    module Style
      # This cop checks for space after `!`.
      #
      # @example
      #   # bad
      #   ! something
      #
      #   # good
      #   !something
      class SpaceAfterNot < Cop
        MSG = 'Do not leave space between `!` and its argument.'

        def on_send(node)
          _receiver, method_name, *_args = *node

          return unless method_name == :!

          if node.loc.expression.source =~ /^!\s+\w+/
            # TODO: Improve source range to highlight the redundant whitespace.
            convention(node, :selector)
          end
        end

        def autocorrect(node)
          @corrections << lambda do |corrector|
            corrector.replace(node.loc.expression,
                              node.loc.expression.source.gsub(/\A!\s+/, '!'))
          end
        end
      end
    end
  end
end
