module Storable
  extend ActiveSupport::Concern
  # For details on the workings of aws-sdk, see the docs at
  # http://docs.aws.amazon.com/AWSRubySDK/latest/frames.html

  def aws_resource_name
    raise "AWS resource name not set."
  end

  def bucket
    @bucket ||= s3.buckets[ENV["ADOPTMEME_AWS_BUCKET_NAME"]]
  end

  def s3
    @s3 ||= AWS::S3.new
  end

  def aws_id
    # Sequential ids are disfavored on S3 for performance
    # reasons. So we reverse the id.
    self.id.to_s.reverse
  end

  def set_amazon_aws_url
    self.amazon_aws_url = Addressable::URI.new(
        scheme: "http",
        host: "s3.amazonaws.com",
        path: [ENV["ADOPTMEME_AWS_BUCKET_NAME"], aws_resource_name].join('/')
      ).to_s
    self.save
  end

  def create_aws_object(content)
    bucket.objects[aws_resource_name].write(content)
    set_amazon_aws_url
  end

  def update_aws_object(content)
    create_aws_object(aws_resource_name, content)
    set_amazon_aws_url
  end

  def delete_aws_object
    bucket.objects[aws_resource_name].delete
    self.amazon_aws_url = ""
    self.save
  end

  def get_aws_object
    bucket.objects[aws_resource_name].read
  end

  def empty_bucket
    bucket.objects.delete_all
  end
end
