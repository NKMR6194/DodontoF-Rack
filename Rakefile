task :default => :setup

TARGET_VERSION = 'Ver.1.48.19'.freeze
FILE_NAME = "DodontoF_#{TARGET_VERSION}.zip".freeze

task :unzip do
  `unzip #{FILE_NAME}`
end

task :download do
  `wget http://www.dodontof.com/DodontoF/#{FILE_NAME}`
end

task :clean do
  `rm -Rf DodontoF_WebSet DodontoF_Ver.*.zip`
end
