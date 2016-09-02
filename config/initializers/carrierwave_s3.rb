CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'AKIAITTZ6BTLK3KHRWVA',
    aws_secret_access_key: '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'
  }
  config.fog_directory  = 'dhsflash-assets'
end