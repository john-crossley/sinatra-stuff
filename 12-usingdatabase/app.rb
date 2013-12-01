require "sinatra/base"

IMAGES = [
  { title: "Image One", url: "/images/0.jpg" },
  { title: "Image Two", url: "/images/1.jpg" },
  { title: "Image Three", url: "/images/2.jpg" }
]

class App < Sinatra::Base

  enable :sessions
  disable :show_exceptions
  register Sinatra::Prawn
  register Sinatra::Namespace

  configure :development do
  end

  configure :production do
  end

  configure do
    # set :environment, ENV["RACK_ENV"]
    # :environment
    # :logging
    # :method_override
    # set :public_folder, "assets"
    # :raise_errors
    # :root
    # :sessions
    # :show_exceptions
    # :static
    # :views

    # set foo: "bar", baz: "foo"
  end

  # All requests that contain the images
  # will execute this before block
  before (/images/) do
    @message = "You're viewing an image"
  end

  # Only be displatched for requests that are not found
  not_found do
    haml :"404", layout: true, layout_engine: :erb
  end

  # Targets any error
  error do
    haml :error, layout: true, layout_engine: :erb
  end

  get "/403" do
    haml :"403", layout: true, layout_engine: :erb
  end

  get "/500" do
    raise StandardError, "Intentional blowing up."
  end

  get "/sample.pdf" do
    # attachment
    content_type :pdf
    @message = "Hello from the PDF!"
    prawn :samplepdf
  end

  before do
    @user = "John Crossley"
    @height  = session[:height]

    @environment = settings.environment

    #logger  = Log4r::Logger["app"]
    #logger.info "~~> Entering request"
  end

  after do
    #logger  = Log4r::Logger["app"]
    #logger.info "<~~ Exiting request"
  end

  get "/sessions/new" do
    erb :"sessions/new"
  end

  post "/sessions" do
    session[:height] = params[:height];
  end

  namespace "/images" do

    get do # /images
      @images = Image.all
      haml :"/images/index", layout_engine: :erb
    end

    get "/:id" do |id|
      @image = Image.get(id)
      haml %s(images/show), layout_engine: :erb
    end

    post do
      @image = Image.create params[:image]
      redirect "/images"
    end

  end

  get "/images" do

    halt 403 if session[:height].nil?

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
