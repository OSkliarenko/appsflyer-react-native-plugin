require 'json'
pkg = JSON.parse(File.read("package.json"))

Pod::Spec.new do |s|
  s.name             = pkg["name"]
  s.version          = pkg["version"]
  s.summary          = pkg["description"]
  s.requires_arc     = true
  s.license          = pkg["license"]
  s.homepage         = pkg["homepage"]
  s.author           = pkg["author"]
  s.source           = { :git => pkg["repository"]["url"] }
  s.source_files     = 'ios/**/*.{h,m}'
  s.platforms    = { :ios => "11.0", :tvos => "11.0" }
  s.swift_version = '4.0'
  s.static_framework = true
  s.dependency 'React'

  # AppsFlyerFramework
  if defined?($RNAppsFlyerStrictMode) && ($RNAppsFlyerStrictMode == true)
    Pod::UI.puts "#{s.name}: Using AppsFlyerFramework/Strict mode"
    s.dependency 'AppsFlyerFramework/Strict', '6.5.2'
    s.xcconfig = {'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) AFSDK_NO_IDFA=1' }
  else
    Pod::UI.puts "#{s.name}: Using default AppsFlyerFramework.You may require App Tracking Transparency. Not allowed for Kids apps."
    Pod::UI.puts "#{s.name}: You may set variable `$RNAppsFlyerStrictMode=true` in Podfile to use strict mode for kids apps."
    s.dependency 'AppsFlyerFramework', '6.5.2'
  end
end
