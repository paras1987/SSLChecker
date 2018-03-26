require_relative 'Website'
require 'date'

describe Website do

  it "#validate_the_Certificate" do
    subject.setURL('https://www.google.com')
    certificateDetails = subject.validate()
    puts certificateDetails
    validity = certificateDetails[:valid_until]
    now = Date.today
    expect(validity - 30).to be > now
  end
end
