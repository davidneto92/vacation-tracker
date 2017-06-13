# This is currently in the users controller because
# I am not sure how best to get it to load otherwise,

# class MapFileUploader
#   def self.perform(file_data)
#     s3 = Aws::S3::Resource.new(region:'us-east-1')
#     obj = s3.bucket(ENV['AWS_BUCKET']).object(file_data[1])
#     obj.upload_file(file_data[0])
#   end
# end
