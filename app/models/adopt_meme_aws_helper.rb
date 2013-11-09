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

  def aws_resource_name
    "#{self.aws_id}.jpg"
  end

  def create_aws_object(object_name, content)
    bucket.objects[object_name].write(content)
  end

  def update_aws_object(object_name, content)
    create_aws_object(object_name, content)
  end

  def delete_aws_object(object_name)
    bucket.objects[object_name].delete
  end

  def get_aws_object(name)
    bucket.objects[object_name].read
  end
end