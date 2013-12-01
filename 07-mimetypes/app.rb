require "sinatra/base"

IMAGES = [
  { title: "Image One", url: "/images/0.jpg" },
  { title: "Image Two", url: "/images/1.jpg" },
  { title: "Image Three", url: "/images/2.jpg" }
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

  get "/images/:index/download" do |index|

    @image = IMAGES[index.to_i]

    # Forces the app to make it a downloadable file
    attachment @image[:title]
    send_file "images/#{index}.jpg"
  end

  get "/images/:index.?:format?" do |index, format|

    index  = index.to_i
    @image = IMAGES[index]
    @index = index

    if format == "jpg"
      content_type :jpg # images/jpeg
      send_file "images/#{index}.jpg"
    else
      haml :"images/show", layout: true
    end

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
