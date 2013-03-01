Pod::Spec.new do |s|
  s.name     = "BBBootstrap"
  s.version  = "1.0.0"
  s.summary  = "A comprehensive bundle of time-savers, for iOS and OSX development."
  s.homepage = "https://github.com/brunodecarvalho/BBBootstrap"
  s.license  = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author   = { "Bruno de Carvalho" => "bruno@biasedbit.com" }
  s.source   = { :git => "https://github.com/brunodecarvalho/BBBootstrap.git", :tag => "1.0.0" }

  s.requires_arc = true

  s.ios.deployment_target = "5.0"
  s.ios.source_files = "Classes/**/*.{h,m}"
  s.ios.frameworks = "UIKit"

  s.osx.deployment_target = "10.7"
  s.osx.source_files = FileList["Classes/**/*.{h,m}"].exclude("Classes/UIKitExtensions")
  s.osx.frameworks = "AppKit"
end
