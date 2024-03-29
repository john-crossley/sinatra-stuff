require "rubygems"
require "json"
Bundler.require # All the gems in the gemfile
require "./app"
require "./db"

logger = Log4r::Logger.new "app"
logger.outputters << Log4r::Outputter.stderr
# logger.outputters << Log4r::Outputter.stdout

file = Log4r::FileOutputter.new('app-file', filename: 'log/app.log')
file.formatter = Log4r::PatternFormatter.new(pattern: "[%l] %d :: %m")

logger.outputters << file

run App
