require "sinatra/base"

IMAGES = [
  { title: "Image One", url: "http://placekitten.com/200/300" },
  { title: "Image Two", url: "http://placekitten.com/g/200/300" },
  { title: "Image Three", url: "http://placekitten.com/200/300" }
]

class App < Sinatra::Base

  enable :sessions

  # All requests that contain the images
  # will execute this before block
  before /images/ do
    @message = "You're viewing an image"
  end

  before do
    @user = "John Crossley"
    @height  = session[:height]
    logger  = Log4r::Logger["app"]
    logger.info "~~> Entering request"
  end

  after do
    logger  = Log4r::Logger["app"]
    logger.info "<~~ Exiting request"
  end

  get "/sessions/new" do
    erb :"sessions/new"
  end

  post "/sessions" do
    session[:height] = params[:height];
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
