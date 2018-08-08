module Monkey
    class Token
        attr_reader :token, :value, :column, :line

        def initialize(token, value = nil, column = -1, line = -1)
            @token = token
            @value = value
            @column = column
            @line = line
        end
    end

    class Tokenizer

        attr_reader :position, :line, :column

        def initialize
            @position = -1
            @column = -1
        end

        def get_tokens(input)
            tokens = []
        
            loop do
                advance

                break if @position == input.length

                tokens << case input[@position]
                when '{' then Token.new(:lbrace)
                when '}' then Token.new(:rbrace)
                when '(' then Token.new(:lparens)
                when ')' then Token.new(:rparens)
                when '[' then Token.new(:lsqbracket)
                when ']' then Token.new(:rsqbracket)
                end
            end

            tokens
        end

        private

        def advance
            @position += 1
            @column += 1
        end

    end
end