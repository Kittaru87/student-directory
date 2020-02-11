# attempting to try TDD

require 'full_directory'

describe 'question' do
  it 'prints user input' do
    expect(question("What is your name?")).to eq "What is your name?"
  end
end
