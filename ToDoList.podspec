#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "ToDoList"
  s.version          = '0.1.5'
  s.summary          = "A ToDo List implemented using ShinobiGrids"
  s.description      = <<-DESC
                       A ToDoList which uses ShinobiGrids to allow the user to add, edit and remove tasks
                       DESC
  s.homepage         = "http://www.shinobicontrols.com"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "Alison Clarke" => "aclarke@shinobicontrols.com" }
  s.source           = { :git => "https://bitbucket.org/shinobicontrols/play-todo-list.git", 
                         :tag => s.version.to_s,
                         :submodules => true 
                       }
  s.social_media_url = 'https://twitter.com/shinobicontrols'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'ToDoList/ToDoList/**/*.{h,m}'
  s.dependency 'ShinobiPlayUtils'
  s.resources = ['ToDoList/**/*.storyboard', 'ToDoList/**/*.xib', 'ToDoList/**/*.xcassets']
  s.frameworks = 'QuartzCore', 'ShinobiGrids'
  s.xcconfig     = { 'FRAMEWORK_SEARCH_PATHS' => '"$(DEVELOPER_FRAMEWORKS_DIR)" "$(PROJECT_DIR)/../"' }
end
