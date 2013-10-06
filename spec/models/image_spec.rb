require 'spec_helper'

describe Image do
  subject(:img) { Image.create(uri: 'fry.jpg') }

  it { should be_valid }
  it { should respond_to(:captions) } 
  it { should respond_to(:uploader) }
  it { should respond_to(:uri) }
end
