if defined?(AssetSync)
  AssetSync.configure do |config|

    if Rails.env.production? 
      config.fog_provider = ENV['FOG_PROVIDER']
      config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
      config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
      config.fog_directory = ENV['FOG_DIRECTORY']
    else
			y = YAML.load_file(File.open(Rails.root.join("config", "s3.yml")))
      config.fog_provider = y["development"]["fog_provider"]
      config.aws_access_key_id = y["development"]["access_key_id"]
      config.aws_secret_access_key = y["development"]["secret_access_key"]
      config.fog_directory = y["development"]["fog_directory"]
    end
    # Increase upload performance by configuring your region
    config.fog_region = 'eu-west-1'
    #
    # Don't delete files from the store
    config.existing_remote_files = "delete"
    #
    # Automatically replace files with their equivalent gzip compressed version
    config.gzip_compression = true
    #
    # Use the Rails generated 'manifest.yml' file to produce the list of files to 
    # upload instead of searching the assets directory.
    # config.manifest = true
    #
    # Fail silently.  Useful for environments such as Heroku
    # config.fail_silently = true
  end
end