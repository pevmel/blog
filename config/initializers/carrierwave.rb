CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
     provider:              'AWS',
     aws_access_key_id:     ENV['S3_ACCESS_KEY'],                        # required unless using use_iam_profile
     aws_secret_access_key: ENV['S3_SECRET_KEY'],                        # required unless using use_iam_profile                 # required
     region:                ENV['S3_REGION']                # optional, defaults to 'us-east-1'
 }
 config.fog_directory  = ENV['S3_BUCKET']
end
