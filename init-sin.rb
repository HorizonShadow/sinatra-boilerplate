require "fileutils"


def make_dirs(root)
  dir_list = [
    "#{root}app/controllers/",
    "#{root}app/helpers",
    "#{root}app/models",
    "#{root}app/views/layouts",
    "#{root}app/views/pages",
    "#{root}app/views/partials",
    "#{root}public/css",
    "#{root}public/js",
    "#{root}public/img",
    "#{root}public/fonts"
  ]
  FileUtils.mkpath(dir_list)
end

def make_files(root)
  file_list = [
    "#{root}main.rb",
    "#{root}Rakefile",
    "#{root}Gemfile",
    "#{root}rackup.rb",
    "#{root}readme.md"
  ]
  FileUtils.touch(file_list)
end

def init_helpers(root)
  str = "
    module Site
  	module Helpers

  		end
  	end
  end
  "

  File.open("#{root}app/helpers/sample.rb", 'w') { |file| file.write(str) }
end

def init_routes(root)
  str = "
  module Site
	module Routes
		class Sample < Sinatra::Application
			helpers Helpers
		end
	end
end
  "
  File.open("#{root}/app/controllers/sample.rb", 'w') { |file| file.write(str) }
end

def init_main(root)
  str = "require 'sinatra'
  require 'sinatra/base'
  require 'sinatra/static_assets'
  require 'sinatra/cookies'
  require 'haml'

  module Site\nclass App < Sinatra::Application

  		Dir[\"./app/helpers/*.rb\"].each { |file| require file }
  		Dir[\"./app/models/*.rb\"].each { |file| require file }
  		Dir[\"./app/controllers/*.rb\"].each { |file| require file }

  		helpers Site::Helpers

  		use Routes::Index
  	end

  end"

  File.open("#{root}main.rb", 'w') { |file| file.write(str) }
end

root = ""
if ARGV[0].nil?
  p "No project name: Create in root folder? (y/n)"
  return if gets == 'n'
else
  root = ARGV[0]
end
make_dirs("#{root}/")
make_files("#{root}/")
init_main("#{root}/")
init_helpers("#{root}/")
init_routes("#{root}/")
