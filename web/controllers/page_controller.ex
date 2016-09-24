defmodule PlibmttbhgatyElixir.PageController do
  use PlibmttbhgatyElixir.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
