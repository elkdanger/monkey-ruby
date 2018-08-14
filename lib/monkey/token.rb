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

    def self.token?(chr)
      Token::TOKEN_MAP.key?(chr.to_sym)
    end

    def self.get_token(chr)
      Token::TOKEN_MAP[chr.to_sym]
    end

    def self.keyword?(chr)
      KEYWORD_MAP.key?(chr.to_sym)
    end

    def self.get_keyword(chr)
      KEYWORD_MAP[chr.to_sym]
    end

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

    KEYWORD_MAP = {
      'let': :let,
      'if': :if,
      'else': :else
    }.freeze
  end
end
