defmodule PlibmttbhgatyElixir.Router do
  use PlibmttbhgatyElixir.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api", PlibmttbhgatyElixir do
    pipe_through :api

    resources "/attendees", AttendeeController, except: [:new, :edit]
    get "/languages", AttendeeController, :languages
    get "/languages/:lang", AttendeeController, :language
  end
end
