CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  elsif Rails.env.development?
    config.storage = :file
  elsif Rails.env.staging?
    config.storage = :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAITTZ6BTLK3KHRWVA',
      aws_secret_access_key: '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'
    }
    config.fog_directory = 'dhsflash-assets'
  elsif Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAITTZ6BTLK3KHRWVA',
      aws_secret_access_key: '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'
    }
    config.fog_directory = 'dhsflash-assets-prod'
  end
end
