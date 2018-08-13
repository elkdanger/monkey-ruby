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
end
