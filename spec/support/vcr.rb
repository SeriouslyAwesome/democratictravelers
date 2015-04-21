VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec', 'vcr')
  c.hook_into :fakeweb
  c.ignore_localhost = true
  c.filter_sensitive_data('<WSDL>') do
    'http://www.webservicex.net:80/uszip.asmx?WSDL'
  end
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join('/')
      .underscore.gsub(/[^\w\/]+/, '_')
    options = example.metadata.slice(:record, :match_requests_on)
      .except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end
