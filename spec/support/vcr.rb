require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec', 'fixtures', 'vcr')
  c.hook_into :webmock
end
