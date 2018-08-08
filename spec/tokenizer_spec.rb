include Monkey

RSpec.describe Monkey::Tokenizer do
    before(:each) do
        @t = Tokenizer.new
    end

    it 'can parse brace symbols' do
        tokens = @t.get_tokens('{}')

        expect(tokens).to have_tokens %i(lbrace rbrace)
    end

    it 'can parse parentheses' do
        tokens = @t.get_tokens('()')
        expect(tokens).to have_tokens %i(lparens rparens)
    end

    it 'can parse square brackets' do
        tokens = @t.get_tokens('[]')
        expect(tokens).to have_tokens %i(lsqbracket rsqbracket)
    end

end