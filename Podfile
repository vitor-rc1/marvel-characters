# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MarvelCharacters' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Pods for MarvelCharacters
  pod 'SwiftHash', git: 'https://github.com/onmyway133/SwiftHash'
  pod 'SDWebImage/MapKit'

  target 'MarvelCharactersTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Mocker'
  end

  target 'MarvelCharactersUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
            end
        end
    end
end
