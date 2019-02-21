module Processor
  class S3Migrator
    S3_BUCKET       = ENV['S3_SITEMAPS_BUCKET']
    CURRENT_FOLDER  = 'sitemaps'

    def initialize
      @s3_client = Aws::S3::Client.new(
          region:            ENV['S3_ASSET_REGION'],
          access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_KEY']
      )
      
      @s3_resource = Aws::S3::Resource.new(
          region:            ENV['S3_ASSET_REGION'],
          access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_KEY']
      )

    end

    def s3_download_files
      s3_current_filenames.each do |o|
        @s3_resource.bucket(S3_BUCKET).object(o).get(response_target: "public/#{o}")
      end
    end

    def s3_current_filenames
      @s3_current_filenames ||= @s3_client
                                    .list_objects(bucket: S3_BUCKET)
                                    .contents
                                    .select { |o| o.key =~ /#{CURRENT_FOLDER}/i }
                                    .select { |o| o.key.split('/').length > 1 }
                                    .map { |r| r.key }
    end
  end
end
