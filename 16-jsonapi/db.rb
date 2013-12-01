env = ENV["RACK_ENV"] || "development"
# url = "mysql://root:root@localhost/dbname"
# url = "postgres://root:root@localhost/dbname"
url = "sqlite://#{Dir.pwd}/db/#{env}.sqlite"
DataMapper.setup :default, url

class Image
  include DataMapper::Resource
  property :id          , Serial
  property :title       , String
  property :url         , String, length: 0..250
  property :description , Text
end

# Make the database stay up to date
DataMapper.finalize
DataMapper.auto_upgrade!
