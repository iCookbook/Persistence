Pod::Spec.new do |s|
  s.name             = 'Persistence'
  s.version          = '0.1.1'
  s.summary          = 'Persistence layer of the project.'
  s.homepage         = 'https://github.com/iCookbook/Persistence'
  s.author           = { 'htmlprogrammist' => '60363270+htmlprogrammist@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/iCookbook/Persistence.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  
  s.source_files = 'Persistence/**/*.{swift}'
  s.resources = 'Persistence/CoreData/**/*.{xcdatamodeld}'
end
