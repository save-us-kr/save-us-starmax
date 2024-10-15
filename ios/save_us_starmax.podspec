Pod::Spec.new do |s|
  s.name             = 'save_us_starmax'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
  DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'tmdgus4475@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*.{h,m,swift}'
  s.dependency       'Flutter'
  s.platform         = :ios, '11.0'
  s.swift_version    = '5.0'
  s.ios.vendored_frameworks = 'Frameworks/RunmefitSDK.framework'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
