Pod::Spec.new do |spec|

  spec.name         = "RudderEvents"
  spec.version      = "1.0.6"
  spec.summary      = "A short description of RudderEvents."
  spec.description  = "don't know about description"

  spec.homepage     = "https://github.com/bajpai-anand/RudderEvents"
  spec.license      = "MIT"
  spec.author       = { "Anand Bajpai" => "anand.bajpai@1mg.com" }

  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/bajpai-anand/RudderEvents.git", :tag =>  spec.version.to_s }

  spec.source_files  = "RudderEvents/**/*.{swift}"
  spec.swift_version = "5.0"

end