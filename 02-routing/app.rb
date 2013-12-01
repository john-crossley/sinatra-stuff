require "sinatra/base"

class App < Sinatra::Base

  get "/" do
    "Hello world via [GET]"
  end

  post "/" do
    "Hello world via [POST]"
  end

  put "/" do
    "Hello world via [PUT]"
  end

  delete "/" do
    "Good bye world via [DELETE]"
  end

  get "/hello/:name" do |name|
    "Hello #{name}"
  end

  get "/greet/:first_name/?:last_name?" do |first, last|
    "Greetings #{first} #{last}"
  end

end
