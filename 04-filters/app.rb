require "sinatra/base"

IMAGES = [
  { title: "Image One", url: "http://placekitten.com/200/300" },
  { title: "Image Two", url: "http://placekitten.com/g/200/300" },
  { title: "Image Three", url: "http://placekitten.com/200/300" }
]

class App < Sinatra::Base

  # All requests that contain the images
  # will execute this before block
  before /images/ do
    @message = "You're viewing an image"
  end

  before do
    @user = "John Crossley"

    puts "~> Entering request"
  end

  after do
    puts "<~ Exiting request"
  end

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
    erb :hello, layout: true
  end

  post "/" do
  end

  put "/" do
  end

  delete "/" do
  end

end
