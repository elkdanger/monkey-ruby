require 'pry'

module Monkey
  # Breaks the text input down into tokens
  class Lexer
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

    def read_next
      advance

      return nil if @eof

      chomp_whitespace

      case @curr_ch
      when '"' then Token.new(:string, read_string)
      else
        if digit?(@curr_ch)
          type, value = read_number
          Token.new(type, value)
        elsif letter?(@curr_ch)
          ident, value = read_ident
          Token.new(ident, value)
        elsif Token.token?(@curr_ch)
          Token.new(Token.get_token(@curr_ch))
        else
          raise "Invalid token #{@curr_ch}" unless token?(@curr_ch)
        end
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
      str = read_while(/[\d.]/)
      float_or_int(str)
    end

    def read_ident
      ident = read_until(/\s/)

      if Token.keyword?(ident)
        [Token.get_keyword(ident), nil]
      else
        [:ident, ident]
      end
    end

    def read_until(regex)
      word = ''

      loop do
        break if @curr_ch =~ regex
        word << @curr_ch
        break unless advance
      end

      word
    end

    def read_while(regex)
      word = ''

      loop do
        break unless @curr_ch =~ regex
        word << @curr_ch
        break unless advance
      end

      word
    end

    def float_or_int(value)
      if value.include? '.'
        [:float, value.to_f]
      else
        [:int, value.to_i]
      end
    end

    def letter?(char)
      char =~ /[a-z]/
    end

    def digit?(char)
      char =~ /\d/
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
