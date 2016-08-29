Pod::Spec.new do |s|
  s.name             = 'Bricks'
  s.version          = '0.1.0'
  s.summary          = 'A Masonry inspired manual layout library.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/mindz_eye/Bricks'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Makarov Yuriy' => 'makarov.yuriy@pixty.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/Bricks.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Bricks/**/*'
  
  # s.resource_bundles = {
  #   'Bricks' => ['Bricks/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
