Dir[File.join(__dir__, '..', 'lib', '**', '*.rb')].each do |file|
    require file
end

RSpec::Matchers.define :have_tokens do |expected|
    match do |actual|
        actual.zip(expected).all? do |a, e|
            a.token == e
        end
    end
end

RSpec.configure do |config|
    
end