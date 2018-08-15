Dir[File.join(__dir__, '..', 'lib', '**', '*.rb')].each do |file|
  require file
end

RSpec::Matchers.define :have_tokens do |expected|
  match do |actual|
    expected.zip(actual).all? do |e, a|
      if e.is_a? Symbol
        a.token == e
      else
        a.token == e.token && a.value == e.value
      end
    end
  end
end

RSpec.configure do |config|
end
