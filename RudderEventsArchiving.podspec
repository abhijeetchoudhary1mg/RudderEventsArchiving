Pod::Spec.new do |spec|

  spec.name         = "RudderEventsArchiving"
  spec.version      = "1.1.8"
  spec.summary      = "A short description of RudderEvents."
  spec.description  = "don't know about description"

  spec.homepage     = "https://github.com/abhijeetchoudhary1mg/RudderEventsArchiving"
  spec.license      = "MIT"
  spec.author       = { "Abhijeet Choudhary" => "abhijeet.choudhary@1mg.com" }

  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/abhijeetchoudhary1mg/RudderEventsArchiving.git", :tag =>  spec.version.to_s }

  spec.source_files  = "RudderEvents/**/*.{swift}"
  spec.swift_version = "5.0"

end