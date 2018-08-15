include Monkey

RSpec.describe Monkey::Lexer do
  def get_tokens_from(input)
    l = Lexer.new(input)

    tokens = []
    token = l.next_token

    while token
      tokens << token
      token = l.next_token
    end

    tokens
  end

  it 'can parse brace symbols' do
    tokens = get_tokens_from '{}'
    expect(tokens).to have_tokens %i[lbrace rbrace]
  end

  it 'can parse parentheses' do
    tokens = get_tokens_from '()'
    expect(tokens).to have_tokens %i[lparens rparens]
  end

  it 'can parse square brackets' do
    tokens = get_tokens_from '[]'
    expect(tokens).to have_tokens %i[lsqbracket rsqbracket]
  end

  it 'can parse math symbols' do
    tokens = get_tokens_from '+-=/%<>'

    expect(tokens).to have_tokens %i[
      plus
      minus
      assign
      divide
      percent
      lt
      gt
    ]
  end

  it 'can read a string' do
    tokens = get_tokens_from '"This is a string"'

    expect(tokens).to have_tokens [
      Token.new(:string, 'This is a string')
    ]
  end

  it 'chomps whitespace' do
    # rubocop:disable Layout/TrailingWhitespace
    tokens = get_tokens_from <<-TEXT
      "This is a string"   
      "This is another string"
    TEXT
    # rubocop:enable Layout/TrailingWhitespace

    expect(tokens).to have_tokens [
      Token.new(:string, 'This is a string'),
      Token.new(:string, 'This is another string')
    ]
  end

  it 'can parse integers' do
    tokens = get_tokens_from '1234'

    expect(tokens).to have_tokens [
      Token.new(:int, 1234)
    ]
  end

  it 'can parse floats' do
    tokens = get_tokens_from '12.34 0.5'

    expect(tokens).to have_tokens [
      Token.new(:float, 12.34),
      Token.new(:float, 0.5)
    ]
  end

  it 'can parse a few symbols together' do
    tokens = get_tokens_from '"hello" 123 {} ()'

    expect(tokens).to have_tokens %i[
      string
      int
      lbrace
      rbrace
      lparens
      rparens
    ]
  end

  context 'identifiers' do
    it 'can understand let' do
      tokens = get_tokens_from 'let name = "Steve"'

      expect(tokens).to have_tokens [
        Token.new(:let),
        Token.new(:ident, 'name'),
        Token.new(:assign),
        Token.new(:string, 'Steve')
      ]
    end

    it 'can understand if' do
      tokens = get_tokens_from 'if {}'

      expect(tokens).to have_tokens %i[
        if
        lbrace
        rbrace
      ]
    end

    it 'can understand else' do
      tokens = get_tokens_from 'if this else that'

      expect(tokens).to have_tokens %i[
        if
        ident
        else
        ident
      ]
    end
  end
end
