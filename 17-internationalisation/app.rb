class App < Sinatra::Base

  enable :sessions
  # Rack lib
  use Rack::Flash
  register Sinatra::Namespace

  helpers do
    def t *args
      I18n.t *args
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end

  before { set_locale }

  get "/" do
    # @message = t "hello.world-with-message", message: "Hi!"
    flash[:notice] = t "hello.world-with-message", message: "Hi!"
    haml :hello
  end

  namespace "/:locale" do

    before { set_locale }

    get do
      @message = t "hello.world-with-message", message: "Hi!"
      haml :hello
    end
  end

end
