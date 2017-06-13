class MapUploader

  def self.perform(print_data)
    temp_upload = Tempfile.new('temp')
    temp_upload.write(print_data[0])
    temp_upload.rewind

    s3 = Aws::S3::Resource.new(region:'us-east-1')
    obj = s3.bucket(ENV['AWS_BUCKET']).object(print_data[1])
    obj.upload_file(temp_upload)

    temp_upload.unlink
  end

end
