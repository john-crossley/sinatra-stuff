require "sinatra/base"

IMAGES = [
  { title: "Image One", url: "http://placekitten.com/200/300" },
  { title: "Image Two", url: "http://placekitten.com/g/200/300" },
  { title: "Image Three", url: "http://placekitten.com/200/300" }
]

class App < Sinatra::Base

  get "/images" do
    @images = IMAGES
    erb :images
  end

  get "/images/:index" do |index|
    index  = index.to_i
    @image = IMAGES[index]
    haml :"images/show", layout: true
  end

  get "/" do
  end

  post "/" do
  end

  put "/" do
  end

  delete "/" do
  end

end
