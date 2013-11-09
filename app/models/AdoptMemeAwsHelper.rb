module AdoptMemeAwsHelper
  def bucket
    @bucket ||= s3.buckets[:adoptmeme]
  end

  def s3
    @s3 ||= AWS::S3.new
  end

  def aws_id
    # Sequential ids are disfavored on S3 for performance reasons.
    # So we reverse the id.
    self.id.to_s.reverse
  end

  def aws_resource_name
    "#{self.aws_id}.jpg"
  end

  def create_aws_object(name, content)
    # Creating objects: http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/S3/S3Object.html
    bucket.objects[name].write(content)
  end
  # handle_asynchronously :create_aws_object

  def delete_aws_object(object_name)
    bucket[object_name].delete
  end
end