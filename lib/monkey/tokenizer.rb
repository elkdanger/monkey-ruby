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
    attr_reader :position, :line, :input, :column, :curr_ch

    def initialize
      @position = -1
      @column = -1
    end

    def get_tokens(input)
      @input = input
      tokens = []

      loop do
        advance

        break if @position == @input.length

        tokens << Token.new(TOKEN_MAP[@curr_ch]) if TOKEN_MAP.key? @curr_ch
      end

      tokens
    end

    private

    TOKEN_MAP = {
      '{': :lbrace,
      '}': :rbrace,
      '(': :lparens,
      ')': :rparens,
      '[': :lsqbracket,
      ']': :rsqbracket,
      '+': :plus,
      '-': :minus,
      '=': :assign,
      '/': :divide,
      '%': :percent,
      '<': :lt,
      '>': :gt
    }.freeze

    def advance
      @position += 1
      @column += 1

      @curr_ch = @input[@position] if @position < @input.length
    end
  end
end
