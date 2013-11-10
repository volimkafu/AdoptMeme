module AdoptMemeAwsHelper
  # For details on the workings of aws-sdk, see the docs at
  # http://docs.aws.amazon.com/AWSRubySDK/latest/frames.html

  BUCKET_NAME = :adoptmeme

  def bucket
    @bucket ||= s3.buckets[BUCKET_NAME]
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
    self.amazon_aws_url = "http://s3.amazonaws.com/adoptmeme/" + aws_resource_name
    self.save
  end

  def create_aws_object(object_name, content)
    bucket.objects[object_name].write(content)
    set_amazon_aws_url
  end

  def update_aws_object(object_name, content)
    create_aws_object(object_name, content)
    set_amazon_aws_url
  end

  def delete_aws_object(object_name)
    bucket.objects[object_name].delete
    self.amazon_aws_url = ""
    self.save
  end

  def get_aws_object(name)
    bucket.objects[object_name].read
  end

  def empty_bucket
    bucket.objects.delete_all
  end
end