RSpec.configure do |rspec|
  rspec.before(:suite) { DatabaseCleaner.clean_with :transaction }
end