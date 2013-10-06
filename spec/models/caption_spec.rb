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
    
  it { should respond_to(:captioner) }
  it { should respond_to(:image) }
  it { should respond_to(:top_text) } 
  it { should respond_to(:bottom_text) }
  
  describe "validations" do
    it "should not allow the top and bottom text to both be blank" do
      caption.top_text = ""
      caption.bottom_text = ""
      expect(caption).not_to be_valid
    end
    
    it "must have a captioner" do
      caption.captioner = nil
      expect(caption).not_to be_valid
    end
    
    it "must have a related image" do
      caption.image = nil
      expect(caption).not_to be_valid
    end
  end
end
