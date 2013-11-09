require 'spec_helper'

describe Caption do

  let (:captioner) { User.new(username: "sampleuser", email: "user@example.com") }
  let (:img) { Image.new(uri: 'fry.jpg')}

  subject(:caption) do
    caption = Caption.new
    caption.captioner = captioner
    caption.image = img
    caption.top_text = "Not sure if trolling"
    caption.bottom_text = "or serious."
    caption.save!
    caption
  end

  it { should respond_to(:top_text) }
  it { should respond_to(:bottom_text) }
  it { should validate_presence_of(:image) }
  it { should belong_to(:captioner) }
  it { should belong_to(:image) }

end
