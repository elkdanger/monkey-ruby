Dir[File.join(__dir__, '..', 'lib', '**', '*.rb')].each do |file|
  require file
end

RSpec::Matchers.define :have_tokens do |expected|
  match do |actual|
    expected.zip(actual).all? do |e, a|
      # rubocop:disable Style/ConditionalAssignment
      if e.is_a? Symbol
        a.token == e
      else
        a.token == e.token
      end
      # rubocop:enable Style/ConditionalAssignment
    end
  end
end

RSpec.configure do |config|
end
