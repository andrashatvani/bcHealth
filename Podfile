platform :ios, '11.0'
use_frameworks!

target 'bcHealth' do
    use_frameworks!

    pod 'Kanna'
    pod 'SwiftLint'
    pod 'SwiftyBeaver'
end

def testing_pods
    pod 'Quick', :git => 'https://github.com/Quick/Quick.git', :branch => 'master'
    pod 'Nimble', :git => 'https://github.com/Quick/Nimble.git', :branch => 'master'
end

target 'bcHealthTests' do
    testing_pods
end

target 'bcHealthUITests' do
    pod 'Kanna'
    pod 'SwiftLint'
    pod 'SwiftyBeaver'
    testing_pods
end

# Manually making Quick compiler version be swift 3.2
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'Quick'
            print "Changing Quick swift version to 3.2\n"
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end

