require 'pry'

module Monkey
  # Represents a single token from the syntax
  class Token
    attr_reader :token, :value, :column, :line

    def initialize(token, value = nil, column = -1, line = -1)
      @token = token
      @value = value
      @column = column
      @line = line
    end
  end

  # Breaks the text input down into tokens
  class Tokenizer
    attr_reader :position, :line, :input, :column, :curr_ch, :eof

    def initialize
      @position = -1
      @column = -1
    end

    def get_tokens(input)
      @input = input
      @eof = @input.length.zero?

      tokens = []

      loop do
        next_token = read_next
        tokens << next_token unless next_token.nil?
        break if next_token.nil?
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

    def token?(chr)
      TOKEN_MAP.key?(chr.to_sym)
    end

    def get_token(chr)
      TOKEN_MAP[chr.to_sym]
    end

    def read_next
      advance

      return nil if @eof

      chomp_whitespace

      case @curr_ch
      when '"' then Token.new(:string, read_string)
      when /\d/ then
        type, value = read_number
        Token.new(type, value)
      else Token.new(get_token(@curr_ch))
      end
    end

    def read_string
      advance
      str = ''

      loop do
        break if @curr_ch == '"'
        str << @curr_ch
        break unless advance
      end

      advance

      str
    end

    def read_number
      str = ''

      loop do
        break unless @curr_ch =~ /[\d.]/
        str << @curr_ch
        break unless advance
      end

      float_or_int(str)
    end

    def float_or_int(value)
      if value.include? '.'
        [:float, value.to_f]
      else
        [:int, str.to_i]
      end
    end

    def chomp_whitespace
      loop do
        break unless @curr_ch =~ /\s/
        break unless advance
      end
    end

    def advance
      @position += 1
      @column += 1
      @eof = @position >= @input.length

      @curr_ch = @input[@position] unless @eof

      !@eof
    end
  end
end
