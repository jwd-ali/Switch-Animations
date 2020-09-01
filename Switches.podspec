
Pod::Spec.new do |s|
  s.name         = "Switches"
  s.version      = "1.0.4"
  s.summary      = "Switches framework"
  s.description  = <<-DESC
                  Switches Pod can create number of beautiful customised switch confirming from UIControl with awesome animations
                   DESC
  s.homepage     = "https://github.com/jwd-ali/IOS-Portfolio"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Jawad Ali" => "L060214@gmail.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/jwd-ali/Switches.git", :tag => "#{s.version}" }

  s.source_files = "Switches/**/*.{h,m,swift}"
  s.requires_arc = true
  s.swift_version = "5.0"
  s.frameworks = "XCTest"
  
end
