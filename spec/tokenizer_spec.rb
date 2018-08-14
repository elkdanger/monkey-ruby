include Monkey

RSpec.describe Monkey::Tokenizer do
  before(:each) do
    @t = Tokenizer.new
  end

  it 'can parse brace symbols' do
    tokens = @t.get_tokens('{}')
    expect(tokens).to have_tokens %i[lbrace rbrace]
  end

  it 'can parse parentheses' do
    tokens = @t.get_tokens('()')
    expect(tokens).to have_tokens %i[lparens rparens]
  end

  it 'can parse square brackets' do
    tokens = @t.get_tokens('[]')
    expect(tokens).to have_tokens %i[lsqbracket rsqbracket]
  end

  it 'can parse math symbols' do
    tokens = @t.get_tokens('+-=/%<>')

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
    tokens = @t.get_tokens '"This is a string"'

    expect(tokens).to have_tokens [
      Token.new(:string, 'This is a string')
    ]
  end

  it 'chomps whitespace' do
    # rubocop:disable Layout/TrailingWhitespace
    tokens = @t.get_tokens <<-TEXT
      "this is a string"   
      "this is another string"
    TEXT
    # rubocop:enable Layout/TrailingWhitespace

    expect(tokens).to have_tokens [
      Token.new(:string, 'This is a string'),
      Token.new(:string, 'This is another string')
    ]
  end

  it 'can parse integers' do
    tokens = @t.get_tokens('1234')

    expect(tokens).to have_tokens [
      Token.new(:int, 1234)
    ]
  end

  it 'can parse floats' do
    tokens = @t.get_tokens('12.34 0.5')

    expect(tokens).to have_tokens [
      Token.new(:float, 12.34),
      Token.new(:float, 0.4)
    ]
  end

  it 'can parse a few symbols together' do
    tokens = @t.get_tokens('"hello" 123 {} ()')

    expect(tokens).to have_tokens %i[
      string
      int
      lbrace
      rbrace
      lparens
      rparens
    ]
  end

  it 'can understand identifiers' do
    tokens = @t.get_tokens('let name = "Steve"')

    expect(tokens).to have_tokens [
      Token.new(:let),
      Token.new(:ident, 'name'),
      Token.new(:assign),
      Token.new(:string, 'Steve')
    ]
  end
end
