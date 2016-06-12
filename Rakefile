# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

require 'afmotion'
require 'bubble-wrap/camera'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'pet-detector-ios'

  app.info_plist['NSAppTransportSecurity'] = {
    'NSAllowsArbitraryLoads' => true
  }

  app.provisioning_profile = "profiles/petdetector.mobileprovision"
  app.identifier = "com.wildmouse.petdetector"
end
