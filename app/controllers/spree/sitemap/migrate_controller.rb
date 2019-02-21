class Spree::Sitemap::MigrateController < Spree::StoreController
  
  def index
    @migrator = Processor::S3Migrator.new
    @migrator.s3_download_files
    
    send_file 'public/sitemaps/sitemap.xml.gz'
  end

end
